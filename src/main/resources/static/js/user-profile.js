document.addEventListener("DOMContentLoaded", async () => {
  // ✅ header/footer include
  fetch("/header.html")
  .then(r => r.text())
  .then(h => (document.getElementById("header-placeholder").innerHTML = h));
  fetch("/footer.html")
  .then(r => r.text())
  .then(h => (document.getElementById("footer-placeholder").innerHTML = h));

  const params = new URLSearchParams(window.location.search);
  const userId = params.get("id");
  if (!userId) {
    alert("잘못된 접근입니다.");
    return;
  }

  try {
    // ✅ 사용자 정보 불러오기
    const res = await fetch(`/api/users/${userId}`);
    if (!res.ok) throw new Error("사용자 정보를 불러올 수 없습니다.");
    const user = await res.json();

    const nameEl = document.getElementById("userName");
    const roleEl = document.getElementById("userRole");
    const profileImgEl = document.getElementById("profileImage");
    const followerCountEl = document.getElementById("followerCount");
    const followingCountEl = document.getElementById("followingCount");

    nameEl.textContent = user.name || "이름 없음";
    roleEl.textContent = user.role || "USER";
    profileImgEl.src = user.profileUrl || "/images/default-profile.png";
    followerCountEl.textContent = `팔로워 ${user.followerCount || 0}`;
    followingCountEl.textContent = `팔로잉 ${user.followingCount || 0}`;

    // ✅ 로그인 사용자 정보 확인
    const meRes = await fetch("/api/me");
    const me = meRes.ok ? await meRes.json() : null;
    const isMe = me && me.userId === user.userId;

    const followBtn = document.getElementById("followBtn");

    if (isMe) {
      followBtn.style.display = "none";
    } else {
      // ✅ 팔로잉 상태 확인
      const statusRes = await fetch(`/api/follows/status/${userId}`);
      let following = statusRes.ok ? await statusRes.json() : false;
      followBtn.textContent = following ? "언팔로우" : "팔로우";

      // ✅ 팔로우/언팔로우 클릭 이벤트
      followBtn.addEventListener("click", async () => {
        try {
          if (!following) {
            // ▶ 팔로우 요청
            const res = await fetch(`/api/follows`, {
              method: "POST",
              headers: { "Content-Type": "application/json" },
              body: JSON.stringify({ followingId: userId }),
            });
            if (!res.ok) throw new Error("팔로우 실패");
            following = true;
            followBtn.textContent = "언팔로우";

            // ✅ 팔로워 수 즉시 반영
            const current = parseInt(followerCountEl.textContent.replace(/\D/g, "")) || 0;
            followerCountEl.textContent = `팔로워 ${current + 1}`;
          } else {
            // ▶ 언팔로우 요청
            const res = await fetch(`/api/follows/${userId}`, { method: "DELETE" });
            if (!res.ok) throw new Error("언팔로우 실패");
            following = false;
            followBtn.textContent = "팔로우";

            // ✅ 팔로워 수 즉시 반영
            const current = parseInt(followerCountEl.textContent.replace(/\D/g, "")) || 0;
            followerCountEl.textContent = `팔로워 ${Math.max(0, current - 1)}`;
          }
        } catch (err) {
          console.error(err);
          alert("팔로우 처리 중 오류 발생");
        }
      });
    }

    // ✅ 게시글 리스트 불러오기
    const postRes = await fetch(`/api/community-posts/${userId}/posts`);
    const posts = postRes.ok ? await postRes.json() : [];
    const listContainer = document.getElementById("userPosts");

    if (!posts.length) {
      listContainer.innerHTML = `<p class="empty-text">${user.name}님이 작성한 게시글이 없습니다.</p>`;
      return;
    }

    // ✅ 게시글 렌더링
    listContainer.innerHTML = posts
    .map(
        post => `
      <div class="community-item" onclick="location.href='/community-detail.html?id=${post.id}'">
        <div class="text">
          <h3 class="title">${post.title}</h3>
          <p class="desc">${
            (post.description || "").length > 80
                ? post.description.slice(0, 80) + "..."
                : post.description
        }</p>
          <div class="meta">
            💬 ${post.commentCount || 0} · ❤️ ${post.likeCount || 0} · 
            ${new Date(post.createdAt).toLocaleDateString("ko-KR", {
          month: "short",
          day: "numeric",
        })}
          </div>
        </div>
        ${
            post.imageUrls && post.imageUrls.length > 0
                ? `<img class="thumb" src="${post.imageUrls[0]}" alt="썸네일">`
                : ""
        }
      </div>`
    )
    .join("");
  } catch (err) {
    console.error(err);
    alert("프로필 로드 중 오류 발생");
  }
});
