// ✅ community.js (ADMIN일 때 미션 없어도 ⋮ 유지 + 모달 UI 완전 통합 + 시간 포맷 수정)

document.addEventListener("DOMContentLoaded", async () => {
  console.log("🚀 community.js 실행됨");

  // ✅ header/footer include
  await Promise.all([
    fetch("/header.html")
    .then(r => r.text())
    .then(h => (document.getElementById("header-placeholder").innerHTML = h)),
    fetch("/footer.html")
    .then(r => r.text())
    .then(h => (document.getElementById("footer-placeholder").innerHTML = h))
  ]);

  // ✅ 로그인 유저 정보 확인
  let user = null;
  try {
    const res = await fetch("/api/me");
    if (!res.ok) throw new Error();
    user = await res.json();
    console.log("🧩 로그인 유저:", user);
    if (!user || !user.id) throw new Error();
  } catch (err) {
    alert("로그인이 필요합니다.");
    location.href = "/login.html";
    return;
  }

  // ✅ 미션 불러오기
  try {
    const missionRes = await fetch("/api/missions/current");
    if (missionRes.ok) {
      const mission = await missionRes.json();
      renderCurrentMission(mission, user);
    } else {
      renderNoMission(user);
    }
  } catch (e) {
    console.error("⚠️ 미션 로드 실패:", e);
    renderNoMission(user);
  }

  // ✅ 커뮤니티 초기화
  initCommunity(user);
});


// ✅ 미션 있음
function renderCurrentMission(mission, user) {
  const container = document.getElementById("currentMission");
  const start = new Date(mission.startDate).toLocaleDateString("ko-KR");
  const end = new Date(mission.endDate).toLocaleDateString("ko-KR");
  const isAdmin = user && user.role && user.role.toUpperCase() === "ADMIN";

  container.innerHTML = `
    <div class="mission-banner">
      <h2>🌿 이번 주 미션: <strong>${mission.title}</strong> 🌿</h2>
      <p class="period">기간: ${start} ~ ${end}</p>
      <p class="desc">${mission.description}</p>
      ${isAdmin ? adminMenuHTML() : ""}
    </div>
  `;

  if (isAdmin) attachAdminMenuHandlers(mission);
}


// ✅ 미션 없음 (ADMIN은 ⋮ 유지)
function renderNoMission(user) {
  const container = document.getElementById("currentMission");
  const isAdmin = user && user.role && user.role.toUpperCase() === "ADMIN";

  container.innerHTML = `
    <div class="mission-banner">
      <h2>🌿 현재 진행 중인 미션이 없습니다 🌿</h2>
      <p class="desc">새로운 미션을 생성해보세요.</p>
      ${isAdmin ? adminMenuHTML() : ""}
    </div>
  `;

  if (isAdmin) attachAdminMenuHandlers(null);
}


// ✅ 관리자 메뉴 HTML 공통
function adminMenuHTML() {
  return `
    <div class="mission-menu">
      <button class="menu-btn" title="관리자 메뉴">⋮</button>
      <div class="menu-dropdown">
        <button id="createMissionBtn">미션 생성</button>
        <button id="editMissionBtn">미션 수정</button>
        <button id="deleteMissionBtn">미션 삭제</button>
      </div>
    </div>`;
}


// ✅ 관리자 메뉴 동작 공통 (모달 UI 적용)
function attachAdminMenuHandlers(mission) {
  const menuBtn = document.querySelector(".menu-btn");
  const dropdown = document.querySelector(".menu-dropdown");

  // 메뉴 토글
  menuBtn.addEventListener("click", (e) => {
    e.stopPropagation();
    dropdown.style.display = dropdown.style.display === "flex" ? "none" : "flex";
  });

  // 외부 클릭 시 닫기
  document.addEventListener("click", (e) => {
    if (!dropdown.contains(e.target) && e.target !== menuBtn) {
      dropdown.style.display = "none";
    }
  });

  // ✅ 모달 관련 엘리먼트
  const modal = document.getElementById("missionModal");
  const form = document.getElementById("missionForm");
  const modalTitle = document.getElementById("modalTitle");
  const titleInput = document.getElementById("missionTitle");
  const descInput = document.getElementById("missionDesc");
  const startInput = document.getElementById("missionStart");
  const endInput = document.getElementById("missionEnd");
  const cancelBtn = document.getElementById("cancelMissionBtn");

  // ✅ 날짜를 로컬 시간대로 변환 (datetime-local 호환)
  function toLocalInputFormat(dateString) {
    if (!dateString) return "";
    const d = new Date(dateString);
    const tzOffset = d.getTimezoneOffset() * 60000; // 분 → ms
    return new Date(d - tzOffset).toISOString().slice(0, 16);
  }

  // 모달 열기
  function openModal(type, data = null) {
    modal.style.display = "flex";
    modalTitle.textContent =
        type === "create" ? "🌱 새 미션 생성" :
            type === "edit" ? "✏️ 미션 수정" :
                "🗑️ 미션 삭제";

    if (type === "create") {
      titleInput.value = "";
      descInput.value = "";
      startInput.value = "";
      endInput.value = "";
    } else if (type === "edit" && data) {
      titleInput.value = data.title;
      descInput.value = data.description;
      startInput.value = toLocalInputFormat(data.startDate);
      endInput.value = toLocalInputFormat(data.endDate);
    }
    form.dataset.mode = type;
  }

  // 모달 닫기
  function closeModal() {
    modal.style.display = "none";
  }

  cancelBtn.addEventListener("click", closeModal);
  modal.addEventListener("click", (e) => {
    if (e.target === modal) closeModal();
  });

  // ✅ “미션 생성”
  document.getElementById("createMissionBtn").addEventListener("click", () => {
    openModal("create");
  });

  // ✅ “미션 수정”
  document.getElementById("editMissionBtn").addEventListener("click", () => {
    if (!mission) return alert("수정할 미션이 없습니다.");
    openModal("edit", mission);
  });

  // ✅ “미션 삭제”
  document.getElementById("deleteMissionBtn").addEventListener("click", async () => {
    if (!mission) return alert("삭제할 미션이 없습니다.");
    if (!confirm("정말 현재 미션을 삭제하시겠습니까?")) return;
    const res = await fetch(`/api/missions/${mission.id}`, { method: "DELETE" });
    if (res.ok) {
      alert("미션이 삭제되었습니다.");
      location.reload();
    } else alert("삭제 실패");
  });

  // ✅ “저장(생성/수정)” 처리
  form.addEventListener("submit", async (e) => {
    e.preventDefault();
    const mode = form.dataset.mode;
    const title = titleInput.value.trim();
    const desc = descInput.value.trim();
    const start = startInput.value;
    const end = endInput.value;

    if (!title || !desc || !start || !end) {
      alert("모든 항목을 입력해주세요.");
      return;
    }

    let url, method;
    if (mode === "create") {
      url = "/api/missions";
      method = "POST";
    } else if (mode === "edit") {
      url = "/api/missions/current";
      method = "PUT";
    }

    const res = await fetch(url, {
      method,
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({ title, description: desc, startDate: start, endDate: end }),
    });

    if (res.ok) {
      alert(mode === "create" ? "새 미션이 생성되었습니다." : "미션이 수정되었습니다.");
      closeModal();
      location.reload();
    } else alert("요청 실패");
  });
}


// ✅ 커뮤니티 초기화
function initCommunity(user) {
  const listContainer = document.getElementById("communityPostList");
  const loadMoreBtn = document.getElementById("loadMoreBtn");
  const searchInput = document.getElementById("searchInput");
  const sortSelect = document.getElementById("sortSelect");
  const searchBtn = document.getElementById("searchBtn");
  const pendingBtn = document.getElementById("pendingBtn");
  const rejectedBtn = document.getElementById("rejectedBtn");

  let nextCursor = null;
  let nextIdAfter = null;
  let hasNext = true;
  let currentKeyword = "";
  let currentSortField = "createdAt";
  let currentSortDirection = "desc";
  let currentView = "approved";

  // ✅ 관리자만 승인/거절 버튼 표시
  if (user && user.role && user.role.toUpperCase() === "ADMIN") {
    pendingBtn.style.display = "inline-block";
    rejectedBtn.style.display = "inline-block";
  }

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

    const endpoint = `/api/mission-posts/${currentView}`;
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
            💬 ${post.commentCount ?? 0} · ❤️ ${post.likeCount ?? 0} · 
            ${new Date(post.createdAt).toLocaleDateString("ko-KR", { month: "short", day: "numeric" })} · 
            ${post.authorName || "익명"}
          </div>
        </div>
        ${post.imageUrls && post.imageUrls.length > 0
        ? `<img class="thumb" src="${post.imageUrls[0]}" alt="thumbnail">`
        : ""}
      </div>
    `).join("");
    listContainer.insertAdjacentHTML("beforeend", html);
  }

  // 검색 / 정렬 / 더보기
  searchBtn.addEventListener("click", () => {
    currentKeyword = searchInput.value.trim();
    loadPosts(true);
  });
  sortSelect.addEventListener("change", () => {
    const [field, dir] = sortSelect.value.split(",");
    currentSortField = field;
    currentSortDirection = dir;
    loadPosts(true);
  });
  loadMoreBtn.addEventListener("click", () => loadPosts());
  pendingBtn.addEventListener("click", () => { currentView = "pending"; loadPosts(true); });
  rejectedBtn.addEventListener("click", () => { currentView = "rejected"; loadPosts(true); });

  loadPosts(true);
}
