let nextCursor = null;
let isLoading = false;

window.addEventListener("DOMContentLoaded", () => {
    loadLayout().then(() => {
        loadPosts();
        controlWriteButtonVisibility();
    });

    document.getElementById("load-more").addEventListener("click", loadPosts);
});

async function loadPosts() {
    if (isLoading) return;
    isLoading = true;

    const postList = document.getElementById("post-list");
    const size = 9; // 한 번에 9개 (3x3)
    const url = nextCursor
        ? `/api/recycling-posts?size=${size}&cursor=${encodeURIComponent(nextCursor)}`
        : `/api/recycling-posts?size=${size}`;

    try {
        const res = await fetch(url);
        if (!res.ok) throw new Error("게시글 불러오기 실패");

        const data = await res.json();
        const posts = data.content;

        posts.forEach(post => {
            const card = document.createElement("div");
            card.className = "post-card";
            card.innerHTML = `
                <img src="${post.thumbNailImageUrl || '/images/default-thumb.jpg'}" alt="${post.title}">
                <div class="info">
                    <div class="title">${post.title}</div>
                    <div class="meta">${post.userName} · ${formatDate(post.createdAt)}</div>
                </div>
            `;
            card.addEventListener("click", () => {
                window.location.href = `/recycling/recycling-detail.html?id=${post.id}`;
            });
            postList.appendChild(card);
        });

        nextCursor = data.nextCursor;
        document.getElementById("load-more").style.display = data.hasNext ? "block" : "none";
    } catch (e) {
        console.error(e);
        postList.innerHTML = `<p>게시글을 불러오는 중 오류가 발생했습니다.</p>`;
    } finally {
        isLoading = false;
    }
}

function formatDate(dateStr) {
    const d = new Date(dateStr);
    return d.toLocaleDateString("ko-KR", { year: "numeric", month: "short", day: "numeric" });
}

// 관리자 전용 글쓰기 버튼 표시
function controlWriteButtonVisibility() {
    const writeBtn = document.querySelector(".btn.write");
    if (!writeBtn) return;

    const isLoggedIn = localStorage.getItem("isLoggedIn") === "true";
    const role = localStorage.getItem("role");
    writeBtn.style.display = (isLoggedIn && role === "ADMIN") ? "inline-block" : "none";
}
