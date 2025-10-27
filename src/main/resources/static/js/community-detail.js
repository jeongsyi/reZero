document.addEventListener("DOMContentLoaded", async () => {
  // header/footer include
  fetch("header.html").then(res => res.text()).then(html => {
    document.getElementById("header-placeholder").innerHTML = html;
  });
  fetch("footer.html").then(res => res.text()).then(html => {
    document.getElementById("footer-placeholder").innerHTML = html;
  });

  const params = new URLSearchParams(window.location.search);
  const postId = params.get("id");
  const detailContainer = document.getElementById("communityDetail");
  const commentList = document.getElementById("commentList");

  try {
    const res = await fetch(`/api/community-posts/${postId}`);
    if (!res.ok) throw new Error("게시글 불러오기 실패");
    const post = await res.json();

    // 🖼️ 이미지 분리 (첫 번째 썸네일, 나머지 갤러리)
    const thumbnail = post.imageUrls?.[0] || "https://via.placeholder.com/800x400?text=reZero";
    const gallery = post.imageUrls?.slice(1) || [];

    detailContainer.innerHTML = `
      <h1>${post.title}</h1>
      <p class="meta">작성자 ${post.userName} · ${new Date(post.createdAt).toLocaleDateString("ko-KR")} · ❤️ ${post.likeCount} · 💬 ${post.commentCount}</p>
      <img class="thumbnail" src="${thumbnail}" alt="thumbnail">
      <div class="description">${post.description.replace(/\n/g, "<br>")}</div>

      ${
        gallery.length
            ? `<div class="image-gallery">
              ${gallery.map(url => `<img src="${url}" alt="gallery">`).join("")}
            </div>`
            : ""
    }
    `;

    // (임시) 댓글 불러오기 — 아직 API 연결 전이라 목업
    const mockComments = [
      { user: "eco_life", content: "정말 공감돼요 🌱", createdAt: "2025-10-27T12:00" },
      { user: "greenlover", content: "사진 너무 예쁘네요!", createdAt: "2025-10-27T14:10" }
    ];
    renderComments(mockComments);

  } catch (err) {
    console.error(err);
    detailContainer.innerHTML = `<p>❌ 게시글을 불러오는 중 오류가 발생했습니다.</p>`;
  }

  // 댓글 등록 이벤트
  document.getElementById("commentForm").addEventListener("submit", e => {
    e.preventDefault();
    const commentInput = document.getElementById("commentInput");
    const content = commentInput.value.trim();
    if (!content) return;

    // 실제 API 연동 시 POST /api/community-posts/{id}/comments
    const newComment = {
      user: "me",
      content,
      createdAt: new Date().toISOString()
    };

    const current = document.querySelectorAll(".comment").length;
    if (current === 0) commentList.innerHTML = ""; // 초기 메시지 제거

    commentList.insertAdjacentHTML("beforeend", commentTemplate(newComment));
    commentInput.value = "";
  });

  function renderComments(comments) {
    if (!comments.length) {
      commentList.innerHTML = "<p>아직 댓글이 없습니다. 첫 댓글을 남겨보세요!</p>";
      return;
    }
    commentList.innerHTML = comments.map(commentTemplate).join("");
  }

  function commentTemplate(c) {
    return `
      <div class="comment">
        <p class="comment-user">${c.user}</p>
        <p class="comment-content">${c.content}</p>
        <p class="comment-date">${new Date(c.createdAt).toLocaleString("ko-KR")}</p>
      </div>
    `;
  }
});
