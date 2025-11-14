const imageInput = document.getElementById('imageInput');
const preview = document.getElementById('preview');
const result = document.getElementById('result');
const video = document.getElementById('camera');
const canvas = document.getElementById('canvas');
const relatedPosts = document.getElementById('relatedPosts');

// 이미지 미리보기
imageInput.addEventListener('change', () => {
    const file = imageInput.files[0];
    if (file) {
        preview.src = URL.createObjectURL(file);
    }
});

// 라벨 → 카테고리 ID 매핑
function mapLabelToCategoryId(label) {
    const mapping = {
        paper: 1,
        plastic: 2,
        vinyl: 3,
        metal: 4,
        glass: 5,
        food: 6,
        textile: 7,
        other: 8
    };
    return mapping[label] || 6;
}

// 이미지 업로드 후 예측 요청
async function sendImage() {
    const file = imageInput.files[0];
    if (!file) return alert("이미지를 선택해주세요!");

    const formData = new FormData();
    formData.append("file", file);

    const response = await fetch("/api/predict", {
        method: "POST",
        body: formData
    });

    const data = await response.json();
    result.innerText = `예측 결과: ${data.label}`;
    const categoryId = mapLabelToCategoryId(data.label);
    fetchRecyclingPostsByCategoryId(categoryId);
}

// 카메라 연결
navigator.mediaDevices.getUserMedia({video: true})
    .then(stream => {
        video.srcObject = stream;
    });

// 사진 촬영 후 예측 요청
function capture() {
    canvas.width = video.videoWidth;
    canvas.height = video.videoHeight;
    canvas.getContext('2d').drawImage(video, 0, 0);
    canvas.toBlob(async blob => {
        preview.src = URL.createObjectURL(blob);

        const formData = new FormData();
        formData.append("file", blob, "capture.jpg");

        const response = await fetch("/api/predict", {
            method: "POST",
            body: formData
        });

        const data = await response.json();
        result.innerText = `예측 결과: ${data.label}`;
        const categoryId = mapLabelToCategoryId(data.label);
        fetchRecyclingPostsByCategoryId(categoryId);
    });
}

// 예측 결과 기반 재활용 게시물 조회
async function fetchRecyclingPostsByCategoryId(categoryId) {
    relatedPosts.innerHTML = "";

    try {
        const response = await fetch(`/api/recycling-posts?category=${categoryId}`);
        const data = await response.json();

        const posts = data.contents || data.items || data.content || [];

        if (posts.length > 0) {
            posts.forEach(post => {
                const imageUrl =
                    post.thumbNailImageUrl ||
                    post.thumbNailUrl ||
                    post.thumbnailImageUrl ||
                    '/images/default-thumb.jpg';
                const card = document.createElement("div");
                card.className = "post-card";
                card.innerHTML = `
                    <img src="${imageUrl}" alt="${post.title}">
                    <div class="info">
                        <div class="title">${post.title}</div>
                        <div class="meta">${post.userName || "익명"} · ${formatDate(post.createdAt)}</div>
                    </div>
                `;
                card.addEventListener("click", function () {
                    window.location.href = "/recycling-detail.html?id=" + post.id;
                });
                relatedPosts.appendChild(card);
            });
        } else {
            relatedPosts.innerHTML = "<p>관련 게시물이 없습니다.</p>";
        }
    } catch (error) {
        console.error("게시물 불러오기 실패:", error);
        relatedPosts.innerHTML = "<p>게시물을 불러오는 중 오류가 발생했습니다.</p>";
    }
}

// 날짜 포맷
function formatDate(dateStr) {
    if (!dateStr) return "";
    const d = new Date(dateStr);
    return d.toLocaleDateString("ko-KR", {year: "numeric", month: "short", day: "numeric"});
}
