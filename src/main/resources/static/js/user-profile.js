/* ===============================
   user-profile.js — DM 버튼 + 프로필 + 게시글
   =============================== */

document.addEventListener("DOMContentLoaded", async () => {

  // header/footer include
  await fetch("/header.html")
  .then(r => r.text())
  .then(t => (document.getElementById("header-placeholder").innerHTML = t));

  await fetch("/footer.html")
  .then(r => r.text())
  .then(t => (document.getElementById("footer-placeholder").innerHTML = t));

  const params = new URLSearchParams(window.location.search);
  const userId = params.get("id");

  if (!userId) {
    alert("잘못된 접근입니다.");
    return;
  }

  // 🔥 프로필 정보
  const res = await fetch(`/api/users/${userId}`);
  const user = await res.json();

  document.getElementById("userName").textContent = user.name;
  document.getElementById("userRole").textContent = user.role;
  document.getElementById("profileImage").src =
      user.profileUrl || "/images/default-profile.png";

  // 로그인 사용자
  const meRes = await fetch("/api/me");
  const me = await meRes.json();

  const messageBtn = document.getElementById("messageBtn");

  // 🔥 자기 자신이면 DM 버튼 숨김
  if (me.id === user.id) {
    messageBtn.style.display = "none";
  } else {
    messageBtn.onclick = () => {
      window.location.href = `/chat.html?user=${user.id}`;
    };
  }

  // 🔥 미션 커뮤니티 게시글 로드
  const postsRes = await fetch(`/api/mission-posts/user/${userId}`);
  const posts = await postsRes.json();

  const box = document.getElementById("userPosts");

  if (posts.length === 0) {
    box.innerHTML = `<p class="empty-text">${user.name}님이 작성한 게시글이 없습니다.</p>`;
    return;
  }

  box.innerHTML = posts
  .map(p => `
            <div class="community-item" onclick="location.href='/community-detail.html?id=${p.id}'">
              <div class="text">
                <h3 class="title">${p.title}</h3>
                <div class="meta">
                    ❤️ ${p.likeCount || 0} · 💬 ${p.commentCount || 0} · 
                    ${new Date(p.createdAt).toLocaleDateString("ko-KR")}
                </div>
              </div>
              ${
      p.images && p.images.length > 0
          ? `<img class="thumb" src="${p.images[0]}" />`
          : ""
  }
            </div>
        `)
  .join("");
});
