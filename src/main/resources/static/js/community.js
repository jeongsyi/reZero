document.addEventListener("DOMContentLoaded", async () => {
  // ✅ header/footer include
  await Promise.all([
    fetch("header.html")
    .then(res => res.text())
    .then(html => (document.getElementById("header-placeholder").innerHTML = html)),
    fetch("footer.html")
    .then(res => res.text())
    .then(html => (document.getElementById("footer-placeholder").innerHTML = html))
  ]);

  // ✅ 로그인 여부 확인
  try {
    const authRes = await fetch("/api/me");
    if (authRes.status === 401 || authRes.status === 403) {
      alert("로그인이 필요합니다. 로그인 페이지로 이동합니다.");
      window.location.href = "/login.html";
      return;
    }

    // ✅ 응답이 200이어도 로그인 정보가 없는 경우 (예: null, anonymous 등)
    const data = await authRes.json();
    if (!data || !data.id) {
      alert("로그인이 필요합니다. 로그인 페이지로 이동합니다.");
      window.location.href = "/login.html";
      return;
    }
  } catch (err) {
    console.error("인증 확인 중 오류:", err);
    alert("로그인이 필요합니다. 로그인 페이지로 이동합니다.");
    window.location.href = "/login.html";
    return;
  }

  // ✅ 로그인 통과 후 커뮤니티 로직 실행
  initCommunity();
});

function initCommunity() {
  const listContainer = document.getElementById("communityPostList");
  const loadMoreBtn = document.getElementById("loadMoreBtn");
  const searchInput = document.getElementById("searchInput");
  const sortSelect = document.getElementById("sortSelect");
  const searchBtn = document.getElementById("searchBtn");
  const feedBtn = document.getElementById("feedBtn");

  let nextCursor = null;
  let nextIdAfter = null;
  let hasNext = true;

  let currentKeyword = "";
  let currentSortField = "createdAt";
  let currentSortDirection = "desc";
  let showingFeed = false;

  // 🔹 게시글 불러오기
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

    const endpoint = showingFeed ? `/api/community-posts/feed` : `/api/community-posts`;

    try {
      const res = await fetch(`${endpoint}?${params.toString()}`);
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
            ${new Date(post.createdAt).toLocaleDateString("ko-KR", { month: "short", day: "numeric" })} · ${post.userName || "익명"}
          </div>
        </div>
        ${post.imageUrls && post.imageUrls.length > 0
        ? `<img class="thumb" src="${post.imageUrls[0]}" alt="thumbnail">`
        : ""}
      </div>
    `).join("");
    listContainer.insertAdjacentHTML("beforeend", html);
  }

  // 🔹 검색 버튼
  searchBtn.addEventListener("click", () => {
    currentKeyword = searchInput.value.trim();
    loadPosts(true);
  });

  // 🔹 정렬 변경
  sortSelect.addEventListener("change", () => {
    const [field, dir] = sortSelect.value.split(",");
    currentSortField = field;
    currentSortDirection = dir;
    loadPosts(true);
  });

  // 🔹 더보기 버튼
  loadMoreBtn.addEventListener("click", () => loadPosts());

  // 🔹 팔로잉 피드 버튼
  feedBtn.addEventListener("click", () => {
    showingFeed = !showingFeed;
    feedBtn.textContent = showingFeed ? "전체 게시글 보기" : "팔로잉 게시글 보기";
    loadPosts(true);
  });

  // ✅ 첫 로드
  loadPosts(true);
}
