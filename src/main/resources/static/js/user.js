let nextCursor = null;
let nextIdAfter = null;
let hasNext = true;
let isLoading = false;
let lastKeyword = "";
let lastType = "";

document.addEventListener("DOMContentLoaded", () => {
    const searchBtn = document.getElementById("searchBtn");
    const searchInput = document.getElementById("searchInput");
    const searchType = document.getElementById("searchType");

    searchBtn.addEventListener("click", () => searchUsers(true));
    searchInput.addEventListener("keydown", (e) => {
        if (e.key === "Enter") searchUsers(true);
    });

    window.addEventListener("scroll", handleScroll);
});

async function searchUsers(reset = true) {
    const keyword = document.getElementById("searchInput").value.trim();
    const type = document.getElementById("searchType").value;
    const resultContainer = document.getElementById("resultContainer");

    if (reset) {
        resultContainer.innerHTML = "";
        nextCursor = null;
        nextIdAfter = null;
        hasNext = true;
        lastKeyword = keyword;
        lastType = type;
    }

    if (!keyword) {
        resultContainer.innerHTML = "<p class='warning'>검색어를 입력해주세요.</p>";
        return;
    }

    if (!hasNext || isLoading) return;
    isLoading = true;

    try {
        const queryParam = new URLSearchParams({
            size: 12,
            sortField: "name",
            sortDirection: "asc",
        });

        if (type === "id") queryParam.append("id", keyword);
        else queryParam.append("name", keyword);

        if (nextCursor && nextIdAfter) {
            queryParam.append("cursor", nextCursor);
            queryParam.append("idAfter", nextIdAfter);
        }

        const res = await fetch(`/api/list?${queryParam.toString()}`);
        if (!res.ok) throw new Error("사용자 검색 실패");

        const data = await res.json();
        const users = data.elements || data.items || data.content || [];
        nextCursor = data.nextCursor || null;
        nextIdAfter = data.nextIdAfter || null;
        hasNext = !!data.hasNext;

        if (users.length === 0 && reset) {
            resultContainer.innerHTML = "<p class='empty'>검색 결과가 없습니다.</p>";
            return;
        }

        const grid =
            resultContainer.querySelector(".user-grid") ||
            document.createElement("div");
        grid.className = "user-grid";

        users.forEach((u) => {
            const card = document.createElement("div");
            card.className = "user-card";
            card.dataset.id = u.id;
            card.innerHTML = `
        <img src="${u.profileUrl || "/images/default-profile.png"}"
             alt="${u.name}"
             onerror="this.onerror=null;this.src='/images/default-profile.png';" />
        <div class="user-info">
          <p class="user-name">${u.name}</p>
          <small class="user-role">${u.role}</small>
          <small class="user-follow">팔로워 ${u.followerCount ?? 0} · 팔로잉 ${u.followingCount ?? 0}</small>
        </div>
      `;
            card.addEventListener("click", () => {
                const userId = card.dataset.id;
                window.location.href = `/user-profile.html?id=${userId}`;
            });
            grid.appendChild(card);
        });

        if (!resultContainer.contains(grid)) resultContainer.appendChild(grid);

    } catch (err) {
        console.error("검색 실패:", err);
        if (reset)
            resultContainer.innerHTML =
                "<p class='error'>검색 중 오류가 발생했습니다.</p>";
    } finally {
        isLoading = false;
    }
}

// 🔹 스크롤 하단 감지 (무한 스크롤)
async function handleScroll() {
    if (isLoading || !hasNext) return;

    const scrollPosition = window.innerHeight + window.scrollY;
    const threshold = document.body.offsetHeight - 200;

    if (scrollPosition >= threshold) {
        await searchUsers(false);
    }
}
