let cursor = null;
let idAfter = null;
let loading = false;
const postList = document.getElementById("post-list");
const loadMoreBtn = document.getElementById("load-more");

async function loadRecyclingPosts() {
    if (loading) return;
    loading = true;
    loadMoreBtn.disabled = true;
    loadMoreBtn.innerText = "불러오는 중...";

    const params = new URLSearchParams({
        size: 10,
        sortField: "createdAt",
        sortDirection: "desc",
    });

    if (cursor && idAfter) {
        params.append("cursor", cursor);
        params.append("idAfter", idAfter);
    }

    try {
        const res = await fetch(`/api/recycling-posts?${params.toString()}`);
        if (!res.ok) throw new Error("API 요청 실패");
        const data = await res.json();

        if (!data.content || data.content.length === 0) {
            if (!cursor) postList.innerHTML = "<p>등록된 게시글이 없습니다.</p>";
            loadMoreBtn.style.display = "none";
            return;
        }

        renderRecyclingPosts(data.content);

        // 다음 커서 갱신
        cursor = data.nextCursor;
        idAfter = data.nextIdAfter;

        if (!data.hasNext) loadMoreBtn.style.display = "none";
    } catch (err) {
        console.error("게시글 불러오기 실패:", err);
        postList.innerHTML = "<p>게시글을 불러오지 못했습니다.</p>";
    } finally {
        loading = false;
        loadMoreBtn.disabled = false;
        loadMoreBtn.innerText = "더보기";
    }
}

function renderRecyclingPosts(posts) {
    const html = posts
        .map(
            (p) => `
      <article class="post-card" onclick="location.href='recycling-detail.html?id=${p.id}'">
        <h2>${p.title}</h2>
        <p class="desc">${p.description || "내용 없음"}</p>
        <div class="meta">
          <span>작성자: ${p.userName}</span>
          <span>${new Date(p.createdAt).toLocaleDateString()}</span>
        </div>
      </article>
    `
        )
        .join("");

    if (cursor) postList.insertAdjacentHTML("beforeend", html);
    else postList.innerHTML = html;
}

loadMoreBtn.addEventListener("click", loadRecyclingPosts);
window.addEventListener("DOMContentLoaded", loadRecyclingPosts);
