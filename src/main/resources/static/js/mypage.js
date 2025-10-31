let scrapNextCursor = null;
let scrapNextIdAfter = null;
let scrapLoading = false;
let scrapHasNext = true;
let likeNextCursor = null;
let likeNextIdAfter = null;
let likeLoading = false;
let likeHasNext = true;

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
        if (!res.ok) throw new Error("프로필 조회 실패");
        const profile = await res.json();

        const profileImg = document.getElementById("profileImage");
        profileImg.src = profile.profileUrl || "/images/default-profile.png";
        profileImg.onerror = () => {
            profileImg.src = "/images/default-profile.png";
        };

        document.getElementById("userName").textContent = profile.name;
        document.getElementById("userRole").textContent = profile.role;
        document.getElementById("userRegion").textContent = profile.region || "-";
        document.getElementById("userBirth").textContent = profile.birth || "-";
        document.querySelector("#followerCount b").textContent =
            profile.followerCount || 0;
        document.querySelector("#followingCount b").textContent =
            profile.followingCount || 0;

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

    const form = document.getElementById("profileEditForm");
    const formData = new FormData();

    // JSON 부분 (ProfileUpdateRequest)
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
        new Blob([JSON.stringify(request)], { type: "application/json" })
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

        // 다시 프로필 불러오기
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
            document.getElementById(btn.dataset.tab).classList.add("active");

            if (btn.dataset.tab === "scrap") loadScraps(true);
            if (btn.dataset.tab === "like") loadLikes();
            if (btn.dataset.tab === "edit") loadEditForm();
        });
    });
}

// 🔹 스크랩 목록 (무한 스크롤)
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
            url += `&cursor=${encodeURIComponent(
                scrapNextCursor
            )}&idAfter=${scrapNextIdAfter}`;

        const res = await fetch(url);
        if (!res.ok) throw new Error("스크랩 로드 실패");
        const data = await res.json();

        // ✅ CursorPageResponse 구조 보정
        const scraps = data.elements || data.items || data.content || [];

        if (scraps.length === 0 && reset) {
            container.innerHTML =
                "<p style='text-align:center;color:#666;'>스크랩한 게시글이 없습니다.</p>";
            return;
        }

        const grid =
            container.querySelector(".post-grid") || document.createElement("div");
        grid.className = "post-grid";

        for (const scrap of scraps) {
            const postRes = await fetch(`/api/recycling-posts/${scrap.postId}`);
            if (!postRes.ok) continue;
            const post = await postRes.json();

            const card = document.createElement("div");
            card.className = "post-card compact";
            card.innerHTML = `
        <img src="${
                post.thumbNailImageUrl || "/images/default-thumb.png"
            }" alt="썸네일" />
        <div class="title-wrap">
            <p class="title" title="${post.title || "제목 없음"}">
              ${post.title || "제목 없음"}
            </p>
        </div>
      `;
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

        const grid = container.querySelector(".post-grid") || document.createElement("div");
        grid.className = "post-grid";

        for (const like of likes) {
            // 커뮤니티 게시글 상세 조회
            const postRes = await fetch(`/api/community-posts/${like.postId}`);
            if (!postRes.ok) continue;
            const post = await postRes.json();

            const card = document.createElement("div");
            card.className = "post-card compact";
            card.innerHTML = `
                <img src="${post.thumbNailImageUrl || '/images/default-thumb.png'}" alt="썸네일" />
                <div class="title-wrap">
                    <p class="title" title="${post.title || '제목 없음'}">${post.title || '제목 없음'}</p>
                </div>
            `;
            card.addEventListener("click", () => {
                window.location.href = `/community-detail.html?id=${post.id}`;
            });

            grid.appendChild(card);
        }

        if (!container.contains(grid)) container.appendChild(grid);

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

function openFollowList(type) {
    const modal = document.createElement("div");
    modal.classList.add("follow-modal", "active");
    modal.innerHTML = `
        <div class="follow-modal-content">
            <h3>${type === "followers" ? "팔로워 목록" : "팔로잉 목록"}</h3>
            <div id="followListContainer">로딩 중...</div>
        </div>
    `;
    modal.addEventListener("click", (e) => {
        if (e.target === modal) modal.remove();
    });
    document.body.appendChild(modal);

    // API 예시
    fetch(`/api/users/${type}`)
        .then(res => res.json())
        .then(data => {
            const list = data.elements || [];
            const container = document.getElementById("followListContainer");
            if (list.length === 0) {
                container.innerHTML = "<p style='text-align:center;color:#777;'>목록이 없습니다.</p>";
                return;
            }
            container.innerHTML = list.map(u => `
                <div class="follow-item-row">
                    <img src="${u.profileUrl || '/images/default-profile.png'}" alt="">
                    <span>${u.name}</span>
                </div>
            `).join('');
        })
        .catch(() => {
            document.getElementById("followListContainer").innerHTML =
                "<p style='text-align:center;color:red;'>불러오기 실패</p>";
        });
}


// 🔹 스크롤 하단 감지
window.addEventListener("scroll", async () => {
    if (scrapLoading || !scrapHasNext) return;
    const activeTab = document.querySelector(".mypage-tabs button.active")
        ?.dataset.tab;
    if (activeTab !== "scrap") return;

    const nearBottom =
        window.innerHeight + window.scrollY >= document.body.offsetHeight - 150;
    if (nearBottom) await loadScraps(false);
});
