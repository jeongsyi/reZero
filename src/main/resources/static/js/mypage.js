// /** ------------------------------
//  *  공통 상태 변수
//  --------------------------------*/
// let scrapNextCursor = null;
// let scrapNextIdAfter = null;
// let scrapLoading = false;
// let scrapHasNext = true;
//
// let likeNextCursor = null;
// let likeNextIdAfter = null;
// let likeLoading = false;
// let likeHasNext = true;
//
// /** ------------------------------
//  *  초기 실행
//  --------------------------------*/
// window.addEventListener("DOMContentLoaded", async () => {
//     await loadLayout();
//     await loadProfile();
//     await setupTabs();
//     await loadScraps(true);
// });
//
// /** ------------------------------
//  *  프로필 로딩
//  --------------------------------*/
// async function loadProfile() {
//     try {
//         const res = await fetch("/api/me");
//         if (!res.ok) throw new Error("프로필 조회 실패");
//
//         const p = await res.json();
//
//         document.getElementById("profileImage").src =
//             p.profileUrl || "/images/default-profile.png";
//
//         document.getElementById("userName").textContent = p.name;
//         document.getElementById("userRole").textContent = p.role;
//         document.getElementById("userRegion").textContent = p.region || "-";
//         document.getElementById("userBirth").textContent = p.birth || "-";
//
//     } catch (e) {
//         console.error("프로필 오류:", e);
//     }
// }
//
// /** ------------------------------
//  *  탭 전환
//  --------------------------------*/
// function setupTabs() {
//     const buttons = document.querySelectorAll(".mypage-tabs button");
//     const panes = document.querySelectorAll(".tab-pane");
//
//     buttons.forEach((btn) => {
//         btn.addEventListener("click", () => {
//             buttons.forEach((b) => b.classList.remove("active"));
//             panes.forEach((p) => p.classList.remove("active"));
//
//             btn.classList.add("active");
//             const pane = document.getElementById(btn.dataset.tab);
//             pane.classList.add("active");
//
//             if (btn.dataset.tab === "scrap") loadScraps(true);
//             if (btn.dataset.tab === "like") loadMissionLikes(true);
//             if (btn.dataset.tab === "community") loadMyMissionPosts(true);
//             if (btn.dataset.tab === "edit") loadEditForm();
//         });
//     });
// }
//
// /** ------------------------------
//  *  스크랩 목록 (기존 동일)
//  --------------------------------*/
// async function loadScraps(reset = true) {
//     const container = document.getElementById("scrap");
//
//     if (reset) {
//         container.innerHTML = "";
//         scrapNextCursor = null;
//         scrapNextIdAfter = null;
//         scrapHasNext = true;
//     }
//
//     if (scrapLoading || !scrapHasNext) return;
//     scrapLoading = true;
//
//     try {
//         let url = `/api/scraps?size=12`;
//         if (scrapNextCursor && scrapNextIdAfter)
//             url += `&cursor=${scrapNextCursor}&idAfter=${scrapNextIdAfter}`;
//
//         const res = await fetch(url);
//         const data = await res.json();
//
//         const scraps = data.content || [];
//
//         const grid =
//             container.querySelector(".post-grid") || document.createElement("div");
//         grid.className = "post-grid";
//
//         for (const item of scraps) {
//             const postRes = await fetch(`/api/recycling-posts/${item.postId}`);
//             if (!postRes.ok) continue;
//             const post = await postRes.json();
//
//             const card = document.createElement("div");
//             card.className = "post-card compact";
//             card.innerHTML = `
//                 <img src="${post.thumbNailImageUrl || "/images/default-thumb.png"}" />
//                 <div class="title-wrap"><p class="title">${post.title}</p></div>
//             `;
//             card.onclick = () =>
//                 (window.location.href = `/recycling-detail.html?id=${post.id}`);
//             grid.appendChild(card);
//         }
//
//         if (!container.contains(grid)) container.appendChild(grid);
//
//         scrapNextCursor = data.nextCursor;
//         scrapNextIdAfter = data.nextIdAfter;
//         scrapHasNext = data.hasNext;
//
//     } catch (err) {
//         console.error("스크랩 로드 오류:", err);
//     } finally {
//         scrapLoading = false;
//     }
// }
//
// /** ------------------------------
//  *  좋아요한 미션 커뮤니티 글 로드
//  --------------------------------*/
// async function loadMissionLikes(reset = true) {
//     const container = document.getElementById("like");
//
//     if (reset) {
//         container.innerHTML = "";
//         likeNextCursor = null;
//         likeNextIdAfter = null;
//         likeHasNext = true;
//     }
//
//     if (likeLoading || !likeHasNext) return;
//     likeLoading = true;
//
//     try {
//         let url = `/api/mission/likes?size=12`;
//         if (likeNextCursor && likeNextIdAfter)
//             url += `&cursor=${likeNextCursor}&idAfter=${likeNextIdAfter}`;
//
//         const res = await fetch(url);
//         const data = await res.json();
//
//         const likes = data.content || [];
//
//         const list = document.createElement("div");
//         list.className = "post-list";
//
//         for (const like of likes) {
//             const postRes = await fetch(`/api/mission-posts/${like.postId}`);
//             if (!postRes.ok) continue;
//             const post = await postRes.json();
//
//             const item = document.createElement("div");
//             item.className = "post-item";
//             item.innerHTML = `
//                 <p class="title">${post.title}</p>
//                 <span class="meta">${new Date(
//                 post.createdAt
//             ).toLocaleDateString("ko-KR")}</span>
//             `;
//             item.onclick = () =>
//                 (window.location.href = `/community-detail.html?id=${post.id}`);
//             list.appendChild(item);
//         }
//
//         container.appendChild(list);
//
//         likeNextCursor = data.nextCursor;
//         likeNextIdAfter = data.nextIdAfter;
//         likeHasNext = data.hasNext;
//
//     } catch (e) {
//         console.error("좋아요 미션 로드 오류:", e);
//     } finally {
//         likeLoading = false;
//     }
// }
//
// /** ------------------------------
//  *  내가 쓴 미션 커뮤니티 글 로드
//  --------------------------------*/
// async function loadMyMissionPosts(reset = true) {
//     const container = document.getElementById("community");
//
//     if (reset) container.innerHTML = "";
//
//     try {
//         const meRes = await fetch("/api/me");
//         const me = await meRes.json();
//
//         const res = await fetch(`/api/mission-posts/user/${me.id}`);
//         const posts = await res.json();
//
//         const list = document.createElement("div");
//         list.className = "post-list";
//
//         posts.forEach((post) => {
//             const item = document.createElement("div");
//             item.className = "post-item";
//             item.innerHTML = `
//                 <p class="title">${post.title}</p>
//                 <span class="meta">${new Date(
//                 post.createdAt
//             ).toLocaleDateString("ko-KR")}</span>
//             `;
//             item.onclick = () =>
//                 (window.location.href = `/community-detail.html?id=${post.id}`);
//             list.appendChild(item);
//         });
//
//         container.appendChild(list);
//     } catch (e) {
//         console.error("내 미션글 로드 오류:", e);
//     }
// }
//
// /** ------------------------------
//  *  프로필 수정 폼 로드
//  --------------------------------*/
// async function loadEditForm() {
//     const res = await fetch("/api/me");
//     const p = await res.json();
//
//     document.getElementById("editUserId").value = p.userId || "";
//     document.getElementById("editName").value = p.name || "";
//     document.getElementById("editRegion").value = p.region || "";
//     document.getElementById("editBirth").value = p.birth || "";
// }
//
// /** ------------------------------
//  *  프로필 수정 요청
//  --------------------------------*/
// document
// .getElementById("profileEditForm")
// ?.addEventListener("submit", async (e) => {
//     e.preventDefault();
//
//     const fd = new FormData();
//     const req = {
//         userId: document.getElementById("editUserId").value,
//         password: document.getElementById("editPassword").value || null,
//         name: document.getElementById("editName").value,
//         region: document.getElementById("editRegion").value,
//         birth: document.getElementById("editBirth").value,
//         deleteProfileImage: false,
//     };
//
//     fd.append("request", new Blob([JSON.stringify(req)], { type: "application/json" }));
//
//     const img = document.getElementById("newProfileImage").files[0];
//     if (img) fd.append("profileImage", img);
//
//     const res = await fetch("/api/me", { method: "PATCH", body: fd });
//
//     if (res.ok) {
//         alert("수정 완료!");
//         loadProfile();
//     } else {
//         alert("수정 실패");
//     }
// });
//
// /** ------------------------------
//  *  무한 스크롤 (스크랩)
//  --------------------------------*/
// window.addEventListener("scroll", async () => {
//     const active = document.querySelector(".mypage-tabs .active")?.dataset.tab;
//     if (active !== "scrap") return;
//
//     if (scrapLoading || !scrapHasNext) return;
//
//     if (window.innerHeight + window.scrollY >= document.body.offsetHeight - 100) {
//         await loadScraps(false);
//     }
// });

/** ------------------------------
 *  공통 상태 변수
 --------------------------------*/
let scrapNextCursor = null;
let scrapNextIdAfter = null;
let scrapLoading = false;
let scrapHasNext = true;

let likeNextCursor = null;
let likeNextIdAfter = null;
let likeLoading = false;
let likeHasNext = true;

/** ------------------------------
 *  초기 실행
 --------------------------------*/
window.addEventListener("DOMContentLoaded", async () => {
    await loadLayout();
    await loadProfile();
    await loadStampBoard();     // ⭐ 도장판
    await setupTabs();
    await loadScraps(true);
});

/** ------------------------------
 *  프로필 로딩
 --------------------------------*/
async function loadProfile() {
    try {
        const res = await fetch("/api/me");
        const p = await res.json();

        document.getElementById("profileImage").src =
            p.profileUrl || "/images/default-profile.png";

        document.getElementById("userName").textContent = p.name;
        document.getElementById("userRole").textContent = p.role;
        document.getElementById("userRegion").textContent = p.region || "-";
        document.getElementById("userBirth").textContent = p.birth || "-";

    } catch (e) {
        console.error("프로필 오류:", e);
    }
}

/** ------------------------------
 * ⭐ 이번 주 도장판 로드
 --------------------------------*/
async function loadStampBoard() {
    const grid = document.getElementById("stampGrid");
    grid.innerHTML = "";

    try {
        const res = await fetch("/api/mission/stamps/week");
        const list = await res.json();

        list.forEach((s) => {
            const cell = document.createElement("div");
            cell.className = "stamp-cell";

            const day = new Date(s.stampDate).toLocaleDateString("ko-KR", {
                weekday: "short"
            });

            cell.innerHTML = `
                <div class="stamp-day">${day}</div>
                <div class="stamp-mark ${s.stamped ? "stamped" : ""}">
                    ${s.stamped ? "✔" : ""}
                </div>
            `;
            grid.appendChild(cell);
        });

    } catch (err) {
        console.error("도장판 오류:", err);
    }
}

/** ------------------------------
 *  탭 메뉴
 --------------------------------*/
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
            if (btn.dataset.tab === "like") loadMissionLikes(true);
            if (btn.dataset.tab === "community") loadMyMissionPosts(true);
            if (btn.dataset.tab === "edit") loadEditForm();
        });
    });
}

/** ------------------------------
 *  스크랩 목록
 --------------------------------*/
async function loadScraps(reset = true) {
    const container = document.getElementById("scrap");

    if (reset) {
        container.innerHTML = "";
        scrapNextCursor = scrapNextIdAfter = null;
        scrapHasNext = true;
    }

    if (scrapLoading || !scrapHasNext) return;
    scrapLoading = true;

    try {
        let url = `/api/scraps?size=12`;
        if (scrapNextCursor)
            url += `&cursor=${scrapNextCursor}&idAfter=${scrapNextIdAfter}`;

        const res = await fetch(url);
        const data = await res.json();
        const scraps = data.content || [];

        const grid =
            container.querySelector(".post-grid") ||
            Object.assign(document.createElement("div"), { className: "post-grid" });

        for (const item of scraps) {
            const postRes = await fetch(`/api/recycling-posts/${item.postId}`);
            if (!postRes.ok) continue;
            const post = await postRes.json();

            const card = document.createElement("div");
            card.className = "post-card compact";
            card.innerHTML = `
                <img src="${post.thumbNailImageUrl || "/images/default-thumb.png"}" />
                <p class="title">${post.title}</p>
            `;
            card.onclick = () => location.href = `/recycling-detail.html?id=${post.id}`;

            grid.appendChild(card);
        }

        if (!container.contains(grid)) container.appendChild(grid);

        scrapNextCursor = data.nextCursor;
        scrapNextIdAfter = data.nextIdAfter;
        scrapHasNext = data.hasNext;

    } catch (e) {
        console.error("스크랩 오류:", e);
    } finally {
        scrapLoading = false;
    }
}

/** ------------------------------
 *  좋아요한 미션 글
 --------------------------------*/
async function loadMissionLikes(reset = true) {
    const container = document.getElementById("like");
    if (reset) container.innerHTML = "";

    try {
        const res = await fetch("/api/mission/likes?size=12");
        const data = await res.json();

        const list = document.createElement("div");
        list.className = "post-list";

        for (const like of data.content || []) {

            const postRes = await fetch(`/api/mission-posts/${like.postId}`);
            const post = await postRes.json();

            const item = document.createElement("div");
            item.className = "post-item";
            item.innerHTML = `
                <p class="title">${post.title}</p>
                <span class="meta">${new Date(post.createdAt).toLocaleDateString()}</span>
            `;
            item.onclick = () => location.href = `/community-detail.html?id=${post.id}`;

            list.appendChild(item);
        }

        container.appendChild(list);

    } catch (e) {
        console.error("좋아요 오류:", e);
    }
}

/** ------------------------------
 *  내가 쓴 글
 --------------------------------*/
async function loadMyMissionPosts(reset = true) {
    const container = document.getElementById("community");
    if (reset) container.innerHTML = "";

    try {
        const me = await (await fetch("/api/me")).json();
        const posts = await (await fetch(`/api/mission-posts/user/${me.id}`)).json();

        const list = document.createElement("div");
        list.className = "post-list";

        posts.forEach((post) => {
            const item = document.createElement("div");
            item.className = "post-item";
            item.innerHTML = `
                <p class="title">${post.title}</p>
                <span class="meta">${new Date(post.createdAt).toLocaleDateString()}</span>
            `;
            item.onclick = () => location.href = `/community-detail.html?id=${post.id}`;
            list.appendChild(item);
        });

        container.appendChild(list);

    } catch (e) {
        console.error("내 글 오류:", e);
    }
}

/** ------------------------------
 *  프로필 수정
 --------------------------------*/
async function loadEditForm() {
    const p = await (await fetch("/api/me")).json();

    editUserId.value = p.userId;
    editName.value = p.name;
    editRegion.value = p.region || "";
    editBirth.value = p.birth || "";
}

/** ------------------------------
 *  무한 스크롤
 --------------------------------*/
window.addEventListener("scroll", () => {
    const active = document.querySelector(".mypage-tabs .active")?.dataset.tab;
    if (active !== "scrap") return;

    if (window.innerHeight + window.scrollY >= document.body.offsetHeight - 100)
        loadScraps(false);
});
