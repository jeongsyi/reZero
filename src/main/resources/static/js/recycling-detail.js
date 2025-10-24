window.addEventListener("DOMContentLoaded", async () => {
    await loadLayout();
    await loadPostDetail();
});

async function loadPostDetail() {
    const params = new URLSearchParams(window.location.search);
    const postId = params.get("id");

    if (!postId) {
        document.body.innerHTML = "<p>잘못된 접근입니다.</p>";
        return;
    }

    try {
        const res = await fetch(`/api/recycling-posts/${postId}`);
        if (!res.ok) throw new Error("게시글 불러오기 실패");

        const post = await res.json();

        // 제목, 작성자, 날짜
        document.getElementById("post-title").textContent = post.title;
        document.getElementById("post-meta").textContent =
            `${post.userName || "익명"} · ${formatDate(post.createdAt)} · ${post.category || "카테고리 없음"}`;

        // 썸네일
        const thumbnail = document.getElementById("thumbnail");
        thumbnail.src = post.thumbNailImageUrl && post.thumbNailImageUrl !== ""
            ? post.thumbNailImageUrl
            : "/images/default-thumb.jpg";

        // 본문
        document.getElementById("post-description").textContent = post.description || "내용이 없습니다.";

        // 이미지 갤러리
        const gallery = document.getElementById("image-gallery");
        gallery.innerHTML = "";
        if (post.imageUrls && post.imageUrls.length > 0) {
            post.imageUrls.forEach(url => {
                const img = document.createElement("img");
                img.src = url;
                img.className = "gallery-image";
                gallery.appendChild(img);
            });
        }
    } catch (e) {
        console.error("상세 불러오기 오류:", e);
        document.querySelector(".recycling-detail").innerHTML =
            "<p>게시글을 불러오는 중 오류가 발생했습니다.</p>";
    }
}

function goBack() {
    window.location.href = "/recycling-list.html";
}

function formatDate(dateStr) {
    if (!dateStr) return "";
    const d = new Date(dateStr);
    return d.toLocaleDateString("ko-KR", { year: "numeric", month: "short", day: "numeric" });
}
