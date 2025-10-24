let nextCursor = null;
let nextIdAfter = null;
let isLoading = false;

window.addEventListener("DOMContentLoaded", () => {
    loadLayout().then(() => {
        loadPosts();
        controlWriteButtonVisibility();
    });

    // ✅ 스크롤 시 자동 로딩
    window.addEventListener("scroll", handleScroll);
});

async function handleScroll() {
    const documentHeight = document.documentElement.scrollHeight;
    const scrollBottom = window.innerHeight + window.scrollY;

    // 스크롤이 바닥 근처 도달 시 다음 페이지 로드
    if (scrollBottom >= documentHeight - 200 && !isLoading && nextCursor) {
        await loadPosts();
    }
}

async function loadPosts() {
    if (isLoading) return;
    isLoading = true;

    const postList = document.getElementById("post-list");
    const size = 20; // ✅ 한 번에 20개씩 가져오기

    // ✅ 커서와 idAfter 모두 전송해야 다음 페이지 로드됨
    const url = nextCursor
        ? `/api/recycling-posts?size=${size}&cursor=${encodeURIComponent(nextCursor)}&idAfter=${nextIdAfter}`
        : `/api/recycling-posts?size=${size}`;

    try {
        const res = await fetch(url);
        if (!res.ok) throw new Error("게시글 불러오기 실패");

        const data = await res.json();
        const posts = Array.isArray(data) ? data : data.content;

        if (!posts || posts.length === 0) {
            if (!nextCursor) {
                postList.innerHTML = `<p style="text-align:center; color:#555;">등록된 게시글이 없습니다.</p>`;
            }
            return;
        }

        posts.forEach(post => {
            const card = document.createElement("div");
            card.className = "post-card";
            card.innerHTML = `
                <img src="${post.thumbNailImageUrl && post.thumbNailImageUrl !== ''
                ? post.thumbNailImageUrl
                : '/images/default-thumb.jpg'}" alt="${post.title}">
                <div class="info">
                    <div class="title">${post.title}</div>
                    <div class="meta">${post.userName || '익명'} · ${formatDate(post.createdAt)}</div>
                </div>
            `;
            card.addEventListener("click", () => {
                window.location.href = `/recycling-detail.html?id=${post.id}`;
            });
            postList.appendChild(card);
        });

        // ✅ 다음 커서 및 다음 idAfter 갱신
        nextCursor = data.nextCursor ?? null;
        nextIdAfter = data.nextIdAfter ?? null;

        // 더 이상 불러올 게시글이 없을 때 스크롤 이벤트 제거
        if (!data.hasNext && !Array.isArray(data)) {
            window.removeEventListener("scroll", handleScroll);
        }

    } catch (e) {
        console.error("게시글 로드 오류:", e);
        if (!postList.innerHTML.trim()) {
            postList.innerHTML = `<p style="text-align:center; color:#b42323;">게시글을 불러오는 중 오류가 발생했습니다.</p>`;
        }
    } finally {
        isLoading = false;
    }
}

function formatDate(dateStr) {
    if (!dateStr) return "";
    const d = new Date(dateStr);
    return d.toLocaleDateString("ko-KR", { year: "numeric", month: "short", day: "numeric" });
}