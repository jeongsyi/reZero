let scrapNextCursor = null;
let scrapNextIdAfter = null;
let scrapLoading = false;
let scrapHasNext = true;

window.addEventListener("DOMContentLoaded", async () => {
    await loadLayout();
    await loadProfile();
    await setupTabs();
});

// 🔹 프로필 불러오기
async function loadProfile() {
    try {
        const res = await fetch("/api/me");
        if (!res.ok) throw new Error("프로필 조회 실패");
        const profile = await res.json();

        document.getElementById("profileImage").src =
            profile.profileUrl || "/images/default-profile.png";
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
        console.error(err);
    }
}

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
