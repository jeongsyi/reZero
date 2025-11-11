let scrapNextCursor = null;
let scrapNextIdAfter = null;
let scrapLoading = false;
let scrapHasNext = true;
let likeNextCursor = null;
let likeNextIdAfter = null;
let likeLoading = false;
let likeHasNext = true;
let followNextCursor = null;
let followNextIdAfter = null;
let followHasNext = true;
let followLoading = false;

window.addEventListener("DOMContentLoaded", async () => {
    await loadLayout();
    await loadProfile();
    await setupTabs();
    await loadScraps(true);
});

// 🔹 프로필 불러오기
async function loadProfile() {
    try {
        const res = await fetch("/api/me");
        console.log("status:", res.status);

        if (res.status === 500) {
            alert("로그인이 필요합니다. 로그인 페이지로 이동합니다.");
            window.location.href = "/login.html";
            return;
        }

        if (!res.ok) throw new Error("프로필 조회 실패");

        const profile = await res.json();

        const profileImg = document.getElementById("profileImage");
        profileImg.src = profile.profileUrl || "/images/default-profile.png";
        profileImg.onerror = () => {
            profileImg.src = "/images/default-profile.png";
        };

        // ✅ 프로필 정보 표시
        document.getElementById("userName").textContent = profile.name;
        document.getElementById("userRole").textContent = profile.role;
        document.getElementById("userRegion").textContent = profile.region || "-";
        document.getElementById("userBirth").textContent = profile.birth || "-";

        // ✅ 팔로워 / 팔로잉 수
        document.querySelector("#followerCount b").textContent =
            profile.followerCount ?? 0;
        document.querySelector("#followingCount b").textContent =
            profile.followingCount ?? 0;

        await loadScraps(true);
    } catch (err) {
        console.error("프로필 로드 오류:", err);
    }
}

// ✅ 프로필 수정 폼 초기화
async function loadEditForm() {
    try {
        const res = await fetch("/api/me");
        if (!res.ok) throw new Error("프로필 로드 실패");
        const data = await res.json();

        document.getElementById("editUserId").value = data.userId || "";
        document.getElementById("editName").value = data.name || "";
        document.getElementById("editRegion").value = data.region || "";
        document.getElementById("editBirth").value = data.birth || "";
    } catch (err) {
        console.error("프로필 수정폼 로드 실패:", err);
    }
}

// ✅ 프로필 수정 요청
document.getElementById("profileEditForm")?.addEventListener("submit", async (e) => {
    e.preventDefault();

    const formData = new FormData();

    const request = {
        userId: document.getElementById("editUserId").value,
        password: document.getElementById("editPassword").value || null,
        name: document.getElementById("editName").value,
        birth: document.getElementById("editBirth").value,
        region: document.getElementById("editRegion").value,
        deleteProfileImage: false,
    };

    formData.append(
        "request",
        new Blob([JSON.stringify(request)], {type: "application/json"})
    );

    const imageFile = document.getElementById("newProfileImage").files[0];
    if (imageFile) formData.append("profileImage", imageFile);

    try {
        const res = await fetch("/api/me", {
            method: "PATCH",
            body: formData,
        });

        if (!res.ok) throw new Error("수정 실패");
        alert("프로필이 성공적으로 수정되었습니다!");

        await loadProfile();
    } catch (err) {
        console.error("프로필 수정 오류:", err);
        alert("수정 중 오류가 발생했습니다.");
    }
});

// 🔹 탭 전환
function setupTabs() {
    const buttons = document.querySelectorAll(".mypage-tabs button");
    const panes = document.querySelectorAll(".tab-pane");

    buttons.forEach((btn) => {
        btn.addEventListener("click", () => {
            buttons.forEach((b) => b.classList.remove("active"));
            panes.forEach((p) => p.classList.remove("active"));
            btn.classList.add("active");

            const targetPane = document.getElementById(btn.dataset.tab);
            if (targetPane) targetPane.classList.add("active");

            if (btn.dataset.tab === "scrap") loadScraps(true);
            if (btn.dataset.tab === "like") loadLikes(true);
            if (btn.dataset.tab === "community") loadMyCommunityPosts(true);
            if (btn.dataset.tab === "edit") loadEditForm();
        });
    });
}

// 🔹 스크랩 목록 (카드형 유지)
async function loadScraps(reset = true) {
    const container = document.getElementById("scrap");

    if (reset) {
        container.innerHTML = "";
        scrapNextCursor = null;
        scrapNextIdAfter = null;
        scrapHasNext = true;
    }

    if (scrapLoading || !scrapHasNext) return;
    scrapLoading = true;

    try {
        let url = `/api/scraps?size=12`;
        if (scrapNextCursor && scrapNextIdAfter)
            url += `&cursor=${encodeURIComponent(scrapNextCursor)}&idAfter=${scrapNextIdAfter}`;

        const res = await fetch(url);
        if (!res.ok) throw new Error("스크랩 로드 실패");
        const data = await res.json();

        const scraps = data.elements || data.items || data.content || [];

        if (scraps.length === 0 && reset) {
            container.innerHTML =
                "<p style='text-align:center;color:#666;'>스크랩한 게시글이 없습니다.</p>";
            return;
        }

        const grid = container.querySelector(".post-grid") || document.createElement("div");
        grid.className = "post-grid";

        for (const scrap of scraps) {
            const postRes = await fetch(`/api/recycling-posts/${scrap.postId}`);
            if (!postRes.ok) continue;
            const post = await postRes.json();

            const card = document.createElement("div");
            card.className = "post-card compact";
            card.innerHTML = `
                <img src="${post.thumbNailImageUrl || "/images/default-thumb.png"}" 
                     alt="썸네일"
                     onerror="this.onerror=null; this.src='/images/default-thumb.png';" />
                <div class="title-wrap">
                  <p class="title" title="${post.title || "제목 없음"}">${post.title || "제목 없음"}</p>
                </div>`;
            card.addEventListener("click", () => {
                window.location.href = `/recycling-detail.html?id=${post.id}`;
            });
            grid.appendChild(card);
        }

        if (!container.contains(grid)) container.appendChild(grid);

        scrapNextCursor = data.nextCursor || null;
        scrapNextIdAfter = data.nextIdAfter || null;
        scrapHasNext = !!data.hasNext;
    } catch (err) {
        console.error("스크랩 불러오기 실패:", err);
        if (reset)
            container.innerHTML =
                "<p>스크랩 데이터를 불러오는 중 오류가 발생했습니다.</p>";
    } finally {
        scrapLoading = false;
    }
}

// 🔹 좋아요 목록 (리스트형)
async function loadLikes(reset = true) {
    const container = document.getElementById("like");

    if (reset) {
        container.innerHTML = "";
        likeNextCursor = null;
        likeNextIdAfter = null;
        likeHasNext = true;
    }

    if (likeLoading || !likeHasNext) return;
    likeLoading = true;

    try {
        let url = `/api/likes?size=12`;
        if (likeNextCursor && likeNextIdAfter)
            url += `&cursor=${encodeURIComponent(likeNextCursor)}&idAfter=${likeNextIdAfter}`;

        const res = await fetch(url);
        if (!res.ok) throw new Error("좋아요 목록 로드 실패");
        const data = await res.json();

        const likes = data.elements || data.items || data.content || [];
        if (likes.length === 0 && reset) {
            container.innerHTML = "<p style='text-align:center;color:#666;'>좋아요한 게시글이 없습니다.</p>";
            return;
        }

        const list = container.querySelector(".post-list") || document.createElement("div");
        list.className = "post-list";

        for (const like of likes) {
            const postRes = await fetch(`/api/community-posts/${like.postId}`);
            if (!postRes.ok) continue;
            const post = await postRes.json();

            const item = document.createElement("div");
            item.className = "post-item";
            item.innerHTML = `
                <p class="title">${post.title || '제목 없음'}</p>
                <span class="meta">${new Date(post.createdAt).toLocaleDateString('ko-KR')}</span>
            `;
            item.addEventListener("click", () => {
                window.location.href = `/community-detail.html?id=${post.id}`;
            });
            list.appendChild(item);
        }

        if (!container.contains(list)) container.appendChild(list);

        likeNextCursor = data.nextCursor || null;
        likeNextIdAfter = data.nextIdAfter || null;
        likeHasNext = !!data.hasNext;
    } catch (err) {
        console.error("좋아요 불러오기 실패:", err);
        if (reset)
            container.innerHTML = "<p>좋아요 데이터를 불러오는 중 오류가 발생했습니다.</p>";
    } finally {
        likeLoading = false;
    }
}

// 🔹 내가 쓴 커뮤니티 게시글 (리스트형)
async function loadMyCommunityPosts(reset = true) {
    const container = document.getElementById("community");

    if (reset) {
        container.innerHTML = "";
    }

    try {
        const meRes = await fetch("/api/me");
        if (!meRes.ok) throw new Error("사용자 정보 불러오기 실패");
        const me = await meRes.json();
        const userId = me.id;

        const res = await fetch(`/api/community-posts/${userId}/posts`);
        if (!res.ok) throw new Error("내 커뮤니티 게시글 불러오기 실패");

        const posts = await res.json();

        if (!posts || posts.length === 0) {
            container.innerHTML =
                "<p style='text-align:center;color:#666;'>작성한 커뮤니티 게시글이 없습니다.</p>";
            return;
        }

        const list = container.querySelector(".post-list") || document.createElement("div");
        list.className = "post-list";

        posts.forEach((post) => {
            const item = document.createElement("div");
            item.className = "post-item";
            item.innerHTML = `
                <p class="title">${post.title || '제목 없음'}</p>
                <span class="meta">${new Date(post.createdAt).toLocaleDateString('ko-KR')}</span>
            `;
            item.addEventListener("click", () => {
                window.location.href = `/community-detail.html?id=${post.id}`;
            });
            list.appendChild(item);
        });

        if (!container.contains(list)) container.appendChild(list);
    } catch (err) {
        console.error("내 커뮤니티 게시글 불러오기 실패:", err);
        container.innerHTML =
            "<p style='text-align:center;color:red;'>게시글을 불러오는 중 오류가 발생했습니다.</p>";
    }
}

// 🔹 팔로우 목록
async function loadFollowList(type, reset = true) {
    const container = document.getElementById("followListContainer");

    if (reset) {
        container.innerHTML = "로딩 중...";
        followNextCursor = null;
        followNextIdAfter = null;
        followHasNext = true;
    }

    if (followLoading || !followHasNext) return;
    followLoading = true;

    try {
        const meRes = await fetch("/api/me");
        if (!meRes.ok) throw new Error("사용자 정보 불러오기 실패");
        const me = await meRes.json();

        let url = `/api/follows/${me.id}/${type}?size=20`;
        if (followNextCursor && followNextIdAfter) {
            url += `&cursor=${encodeURIComponent(followNextCursor)}&idAfter=${followNextIdAfter}`;
        }

        const res = await fetch(url);
        if (!res.ok) throw new Error("팔로우 목록 조회 실패");
        const data = await res.json();

        const list = data.content || data.elements || data.items || [];

        if (reset && list.length === 0) {
            container.innerHTML = `<p style='text-align:center;color:#777;'>${
                type === "follower" ? "팔로워가 없습니다." : "팔로잉한 사용자가 없습니다."
            }</p>`;
            return;
        }

        if (reset) container.innerHTML = "";
        list.forEach((u) => {
            const row = document.createElement("div");
            row.className = "follow-item-row";
            row.dataset.id = u.userId;
            row.dataset.name = (u.name || "").toLowerCase();
            row.innerHTML = `
                <img src="${u.profileUrl || "/images/default-profile.png"}" 
                     alt="프로필" 
                     onerror="this.src='/images/default-profile.png';" />
                <div style="display:flex;flex-direction:column;">
                    <span style="font-weight:600;color:#333;">${u.name}</span>
                    <small style="color:#777;">${u.loginId}</small>
                </div>`;
            row.addEventListener("click", () => {
                window.location.href = `/user-profile.html?id=${row.dataset.id}`;
            });
            container.appendChild(row);
        });

        followNextCursor = data.nextCursor || null;
        followNextIdAfter = data.nextIdAfter || null;
        followHasNext = !!data.hasNext;

    } catch (err) {
        console.error("팔로우 목록 불러오기 실패:", err);
        container.innerHTML =
            "<p style='text-align:center;color:red;'>목록을 불러오는 중 오류가 발생했습니다.</p>";
    } finally {
        followLoading = false;
    }
}

function openFollowList(type) {
    const modal = document.createElement("div");
    modal.classList.add("follow-modal", "active");
    modal.innerHTML = `
    <div class="follow-modal-content">
      <h3>${type === "follower" ? "팔로워 목록" : "팔로잉 목록"}</h3>
      <input type="text" id="followSearchInput" placeholder="이름으로 검색..." 
             style="width:100%; padding:8px; border:1px solid #ccc; border-radius:6px; margin-bottom:12px;" />
     <div id="followListContainer">로딩 중...</div>
    </div>`;

    modal.addEventListener("click", (e) => {
        if (e.target === modal) modal.remove();
    });

    document.body.appendChild(modal);
    loadFollowList(type);

    const container = modal.querySelector("#followListContainer");
    container.addEventListener("scroll", async () => {
        if (followLoading || !followHasNext) return;
        const nearBottom =
            container.scrollTop + container.clientHeight >= container.scrollHeight - 100;
        if (nearBottom) await loadFollowList(type, false);
    });

    const searchInput = modal.querySelector("#followSearchInput");
    searchInput.addEventListener("input", (e) => {
        const keyword = e.target.value.trim().toLowerCase();
        filterFollowList(keyword);
    });
}

// 🔹 검색 필터
function filterFollowList(keyword) {
    const rows = document.querySelectorAll(".follow-item-row");
    rows.forEach((row) => {
        const name = row.dataset.name || "";
        row.style.display = name.includes(keyword) ? "flex" : "none";
    });
}

// 🔹 스크롤 하단 감지 (스크랩)
window.addEventListener("scroll", async () => {
    if (scrapLoading || !scrapHasNext) return;
    const activeTab = document.querySelector(".mypage-tabs button.active")?.dataset.tab;
    if (activeTab !== "scrap") return;

    const nearBottom =
        window.innerHeight + window.scrollY >= document.body.offsetHeight - 150;
    if (nearBottom) await loadScraps(false);
});
