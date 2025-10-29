document.addEventListener("DOMContentLoaded", async () => {
  // header/footer include
  fetch("header.html").then(res => res.text()).then(html => {
    document.getElementById("header-placeholder").innerHTML = html;
  });
  fetch("footer.html").then(res => res.text()).then(html => {
    document.getElementById("footer-placeholder").innerHTML = html;
  });

  const listContainer = document.getElementById("communityPostList");
  const loadMoreBtn = document.getElementById("loadMoreBtn");
  const searchInput = document.getElementById("searchInput");
  const sortSelect = document.getElementById("sortSelect");
  const searchBtn = document.getElementById("searchBtn");

  // 페이지 상태
  let nextCursor = null;
  let nextIdAfter = null;
  let hasNext = true;

  // 현재 필터 상태
  let currentKeyword = "";
  let currentSortField = "createdAt";
  let currentSortDirection = "desc";

  // 🔹 게시글 로드 함수
  async function loadPosts(reset = false) {
    if (reset) {
      listContainer.innerHTML = "";
      nextCursor = null;
      nextIdAfter = null;
      hasNext = true;
    }

    if (!hasNext) return;

    const params = new URLSearchParams({
      size: 10,
      sortField: currentSortField,
      sortDirection: currentSortDirection
    });

    if (currentKeyword) {
      params.append("title", currentKeyword);
      params.append("description", currentKeyword);
      params.append("userName", currentKeyword);
    }

    if (nextCursor && nextIdAfter) {
      params.append("cursor", nextCursor);
      params.append("idAfter", nextIdAfter);
    }

    try {
      const res = await fetch(`/api/community-posts?${params.toString()}`);
      if (!res.ok) throw new Error("게시글 불러오기 실패");
      const data = await res.json();

      renderPosts(data.content);

      nextCursor = data.nextCursor;
      nextIdAfter = data.nextIdAfter;
      hasNext = data.hasNext;

      loadMoreBtn.style.display = hasNext ? "block" : "none";
    } catch (err) {
      console.error(err);
      listContainer.innerHTML = `<p>❌ 게시글을 불러오는 중 오류가 발생했습니다.</p>`;
    }
  }

  // 🔹 게시글 렌더링
  function renderPosts(posts) {
    const html = posts.map(post => `
      <div class="community-item" onclick="location.href='community-detail.html?id=${post.id}'">
        <div class="text">
          <h3 class="title">${post.title}</h3>
          <p class="desc">${(post.description || '').length > 80
        ? post.description.slice(0, 80) + "..."
        : post.description}</p>
          <div class="meta">
            💬 ${post.commentCount} · ❤️ ${post.likeCount} · 
            ${new Date(post.createdAt).toLocaleDateString("ko-KR", { month: "short", day: "numeric" })} · 익명
          </div>
        </div>
        ${post.imageUrls && post.imageUrls.length > 0
        ? `<img class="thumb" src="${post.imageUrls[0]}" alt="thumbnail">`
        : ""}
      </div>
    `).join("");

    listContainer.insertAdjacentHTML("beforeend", html);
  }

  // 🔹 검색 버튼 클릭
  searchBtn.addEventListener("click", () => {
    currentKeyword = searchInput.value.trim();
    loadPosts(true);
  });

  // 🔹 정렬 옵션 변경
  sortSelect.addEventListener("change", () => {
    const [field, dir] = sortSelect.value.split(",");
    currentSortField = field;
    currentSortDirection = dir;
    loadPosts(true);
  });

  // 🔹 더보기 버튼 클릭
  loadMoreBtn.addEventListener("click", () => {
    loadPosts();
  });

  // 첫 로드
  loadPosts(true);
});
