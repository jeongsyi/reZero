window.addEventListener("DOMContentLoaded", async () => {
    await loadLayout();
    await loadEditForm();
});

const postId = new URLSearchParams(window.location.search).get("id");

// 기존 게시글 데이터 불러오기
async function loadEditForm() {
    try {
        const res = await fetch(`/api/recycling-posts/${postId}`);
        if (!res.ok) throw new Error("게시글 불러오기 실패");
        const post = await res.json();

        document.getElementById("title").value = post.title || "";
        document.getElementById("description").value = post.description || "";
        await loadCategories(post.categoryId);

        if (post.thumbNailImageUrl) {
            const preview = document.getElementById("previewThumbnail");
            preview.src = post.thumbNailImageUrl;
            preview.style.display = "block";
        }
    } catch (err) {
        console.error("게시글 로드 실패:", err);
        alert("게시글 정보를 불러오는 중 오류가 발생했습니다.");
    }
}

// 카테고리 목록 로드
async function loadCategories() {
    const res = await fetch("/api/category");
    const categories = await res.json();

    const select = document.getElementById("category");
    categories.forEach(c => {
        const option = document.createElement("option");
        option.value = c.id || c.categoryId;
        option.textContent = c.category || c.name;
        select.appendChild(option);
    });
}

// 미리보기
document.getElementById("thumbnail").addEventListener("change", (e) => {
    const file = e.target.files[0];
    const preview = document.getElementById("previewThumbnail");
    if (file) {
        preview.src = URL.createObjectURL(file);
        preview.style.display = "block";
    }
});

document.getElementById("images").addEventListener("change", (e) => {
    const files = e.target.files;
    const previewContainer = document.getElementById("multiPreview");
    previewContainer.innerHTML = "";
    Array.from(files).forEach(file => {
        const img = document.createElement("img");
        img.src = URL.createObjectURL(file);
        previewContainer.appendChild(img);
    });
});

// 수정 요청
document.getElementById("editForm").addEventListener("submit", async (e) => {
    e.preventDefault();
    const title = document.getElementById("title").value.trim();
    const description = document.getElementById("description").value.trim();
    const categoryId = document.getElementById("category").value || null;
    const thumbnail = document.getElementById("thumbnail").files[0];
    const images = document.getElementById("images").files;

    if (!title || !description) {
        alert("제목과 내용을 입력해주세요.");
        return;
    }

    const formData = new FormData();
    formData.append(
        "request",
        new Blob([JSON.stringify({ title, description, categoryId })], {
            type: "application/json",
        })
    );
    if (thumbnail) formData.append("thumbsNailImage", thumbnail);
    if (images.length > 0)
        Array.from(images).forEach(img => formData.append("images", img));

    try {
        const res = await fetch(`/api/recycling-posts/${postId}`, {
            method: "PATCH",
            body: formData,
        });
        if (res.ok) {
            alert("게시글이 수정되었습니다.");
            window.location.href = `/recycling-detail.html?id=${postId}`;
        } else {
            alert("수정 중 오류가 발생했습니다.");
        }
    } catch (err) {
        console.error(err);
        alert("수정 요청 실패");
    }
});

function goBack() {
    window.history.back();
}
