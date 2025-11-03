let nextCursor = null;
let nextIdAfter = null;
let isLoading = false;

window.addEventListener("DOMContentLoaded", async () => {
    await loadLayout();
    controlWriteButtonVisibility();

    await loadPosts();

    window.addEventListener("scroll", handleScroll);

    document.getElementById("searchBtn").addEventListener("click", resetAndSearch);
    document.getElementById("sortSelect").addEventListener("change", resetAndSearch);
    document.getElementById("limitSelect").addEventListener("change", resetAndSearch);

    // ✅ 검색 타입 변경 시 카테고리 선택창 표시/숨김 처리
    const searchTypeSelect = document.getElementById("searchType");
    const keywordInput = document.getElementById("searchKeyword");

    // 🔹 카테고리 select 추가 (id 기반)
    let categorySelect = document.createElement("select");
    categorySelect.id = "categorySelect";
    categorySelect.style.display = "none";
    categorySelect.innerHTML = `
        <option value="">전체</option>
        <option value="1">종이류</option>
        <option value="2">플라스틱/비닐류</option>
        <option value="3">유리/금속/캔</option>
        <option value="4">음식물/유기물</option>
        <option value="5">천/옷</option>
        <option value="6">기타</option>
    `;
    keywordInput.insertAdjacentElement("afterend", categorySelect);

    searchTypeSelect.addEventListener("change", (e) => {
        const type = e.target.value;
        if (type === "category") {
            keywordInput.style.display = "none";
            categorySelect.style.display = "inline-block";
        } else {
            keywordInput.style.display = "inline-block";
            categorySelect.style.display = "none";
        }
        resetAndSearch();
    });
});

async function handleScroll() {
    const documentHeight = document.documentElement.scrollHeight;
    const scrollBottom = window.innerHeight + window.scrollY;

    if (scrollBottom >= documentHeight - 200 && !isLoading && nextCursor) {
        await loadPosts();
    }
}

async function loadPosts() {
    if (isLoading) return;
    isLoading = true;

    const postList = document.getElementById("post-list");

    const searchType = document.getElementById("searchType")?.value || "title";
    const [sortField, sortDirection] = (document.getElementById("sortSelect")?.value || "createdAt-desc").split("-");
    const size = Number(document.getElementById("limitSelect")?.value || 20);

    let title = "";
    let description = "";
    let categoryId = "";

    if (searchType === "category") {
        categoryId = document.getElementById("categorySelect")?.value || "";
    } else {
        const keyword = document.getElementById("searchKeyword")?.value.trim() || "";
        if (searchType === "title") title = keyword;
        else if (searchType === "description") description = keyword;
    }

    // 커서 기반 URL 구성
    let url = `/api/recycling-posts?title=${encodeURIComponent(title)}&description=${encodeURIComponent(description)}&category=${encodeURIComponent(categoryId)}&sortField=${sortField}&sortDirection=${sortDirection}&size=${size}`;
    if (nextCursor && nextIdAfter) {
        url += `&cursor=${encodeURIComponent(nextCursor)}&idAfter=${nextIdAfter}`;
    }

    try {
        const res = await fetch(url);
        if (!res.ok) throw new Error("게시글 불러오기 실패");

        const data = await res.json();
        const posts = Array.isArray(data) ? data : data.items || data.content;

        if (!posts || posts.length === 0) {
            if (!nextCursor) {
                postList.innerHTML = `<p style="text-align:center; color:#555;">등록된 게시글이 없습니다.</p>`;
            }
            return;
        }
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
                    <div class="meta">
                        ${post.userName || '익명'} · ${formatDate(post.createdAt)} · ⭐ ${post.scrapCount ?? 0}
                    </div>
                </div>
            `;
            card.addEventListener("click", () => {
                window.location.href = `/recycling-detail.html?id=${post.id}`;
            });
            postList.appendChild(card);
        });

        nextCursor = data.nextCursor ?? null;
        nextIdAfter = data.nextIdAfter ?? null;

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

function resetAndSearch() {
    nextCursor = null;
    nextIdAfter = null;
    const postList = document.getElementById("post-list");
    postList.innerHTML = "";
    window.addEventListener("scroll", handleScroll);
    loadPosts();
}

function formatDate(dateStr) {
    if (!dateStr) return "";
    const d = new Date(dateStr);
    return d.toLocaleDateString("ko-KR", {year: "numeric", month: "short", day: "numeric"});
}

function controlWriteButtonVisibility() {
    const writeButton = document.querySelector(".btn.board-write");
    const isLoggedIn = localStorage.getItem("isLoggedIn") === "true";
    const role = localStorage.getItem("role");

    if (isLoggedIn && role === "ADMIN") {
        writeButton.style.display = "inline-block";
    } else {
        writeButton.style.display = "none";
    }
}
