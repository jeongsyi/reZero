document.addEventListener("DOMContentLoaded", async () => {

  fetch("header.html").then(res => res.text()).then(html => {
    document.getElementById("header-placeholder").innerHTML = html;
  });
  fetch("footer.html").then(res => res.text()).then(html => {
    document.getElementById("footer-placeholder").innerHTML = html;
  });

  const params = new URLSearchParams(window.location.search);
  const postId = params.get("id");

  const detailContainer = document.getElementById("communityDetail");
  const postActions = document.getElementById("postActions");
  const likeBtn = document.getElementById("likeBtn");
  const commentList = document.getElementById("commentList");
  const commentForm = document.getElementById("commentForm");
  const commentInput = document.getElementById("commentInput");

  let postData = null;
  let currentUser = null;
  let liked = false;

  /* ==============================================
     ✅ 게시글 불러오기
     ============================================== */
  try {
    const res = await fetch(`/api/community-posts/${postId}`);
    if (!res.ok) throw new Error("게시글 불러오기 실패");
    postData = await res.json();

    const thumbnail = postData.imageUrls?.[0] || null;
    const gallery = postData.imageUrls?.slice(1) || [];

    detailContainer.innerHTML = `
      <h1>${postData.title}</h1>
      <p class="meta">
        작성자 ${postData.userName} · ${new Date(postData.createdAt).toLocaleDateString("ko-KR")} 
        · ❤️ ${postData.likeCount} · 💬 ${postData.commentCount}
      </p>
      ${thumbnail ? `<img class="thumbnail" src="${thumbnail}" alt="thumbnail">` : ""}
      <div class="description">${(postData.description || "").replace(/\n/g, "<br>")}</div>
      ${
        gallery.length
            ? `<div class="image-gallery">${gallery.map(url => `<img src="${url}" alt="gallery">`).join("")}</div>`
            : ""
    }
    `;

    // ✅ 로그인 유저 확인
    const userRes = await fetch("/api/me");
    if (userRes.ok) {
      currentUser = await userRes.json();
      if (currentUser.name === postData.userName) {
        postActions.style.display = "flex";
      }

      // ✅ 좋아요 여부 확인
      const likeCheckRes = await fetch(`/api/likes?postId=${postId}`);
      if (likeCheckRes.ok) {
        const likePage = await likeCheckRes.json();
        liked = likePage.content?.some(like => like.postId === Number(postId)) || false;
      }
    }

    updateLikeButton(postData.likeCount, liked);
    await loadComments(); // ✅ 댓글도 함께 로드
  } catch (err) {
    console.error(err);
    detailContainer.innerHTML = `<p>❌ 게시글을 불러오는 중 오류가 발생했습니다.</p>`;
  }

  /* ==============================================
     ✅ 좋아요 토글
     ============================================== */
  likeBtn.addEventListener("click", async () => {
    if (!currentUser) return alert("로그인 후 이용해주세요.");

    try {
      if (!liked) {
        const res = await fetch(`/api/likes/${postId}`, { method: "POST" });
        if (!res.ok) throw new Error("좋아요 실패");
        liked = true;
        postData.likeCount++;
      } else {
        const res = await fetch(`/api/likes/${postId}`, { method: "DELETE" });
        if (!res.ok) throw new Error("좋아요 취소 실패");
        liked = false;
        postData.likeCount--;
      }
      updateLikeButton(postData.likeCount, liked);
    } catch (err) {
      console.error(err);
      alert("❌ 좋아요 처리 중 오류가 발생했습니다.");
    }
  });

  /* ==============================================
     ✅ 수정 / 삭제 버튼
     ============================================== */
  document.getElementById("editBtn").addEventListener("click", () => {
    if (!postData) return;
    const query = new URLSearchParams({
      id: postData.id,
      title: postData.title,
      description: postData.description
    });
    location.href = `community-edit.html?${query.toString()}`;
  });

  document.getElementById("deleteBtn").addEventListener("click", async () => {
    if (!confirm("정말로 이 글을 삭제하시겠습니까?")) return;
    try {
      const res = await fetch(`/api/community-posts/${postData.id}`, { method: "DELETE" });
      if (!res.ok) throw new Error("삭제 실패");
      alert("🗑️ 게시글이 삭제되었습니다.");
      location.href = "community.html";
    } catch (err) {
      alert("❌ 삭제 중 오류가 발생했습니다.");
      console.error(err);
    }
  });

  /* ==============================================
     ✅ 댓글 목록 불러오기
     ============================================== */
  async function loadComments() {
    commentList.innerHTML = "";
    try {
      // ✅ 백엔드가 community-comments?postId= 형태여도 작동
      const res = await fetch(`/api/community-comments?postId=${postId}`);
      if (!res.ok) throw new Error("댓글 불러오기 실패");
      const data = await res.json();

      // ✅ 응답이 배열 or { content: [] } 모두 대응
      const comments = data.content || data;

      if (!comments || comments.length === 0) {
        commentList.innerHTML = `<p style="color:#666;">아직 댓글이 없습니다.</p>`;
        return;
      }

      for (const comment of comments) {
        renderComment(comment);
        if (comment.children && comment.children.length > 0) {
          for (const child of comment.children) {
            renderComment(child, true);
          }
        }
      }
    } catch (err) {
      console.error("❌ 댓글 불러오기 오류:", err);
      commentList.innerHTML = `<p>댓글을 불러오는 중 오류가 발생했습니다.</p>`;
    }
  }

  /* ==============================================
     ✅ 댓글 렌더링
     ============================================== */
  function renderComment(comment, isReply = false) {
    const wrapper = document.createElement("div");
    wrapper.className = "comment";
    wrapper.style.marginLeft = isReply ? "30px" : "0";

    wrapper.innerHTML = `
      <div class="comment-user">${comment.userName}</div>
      <div class="comment-content">${comment.content}</div>
      <div class="comment-date">${new Date(comment.createdAt).toLocaleString("ko-KR")}</div>
      ${
        currentUser && currentUser.name === comment.userName
            ? `
            <div class="comment-actions" style="margin-top:5px;">
              <button class="btn edit" data-id="${comment.id}" style="padding:4px 8px;">수정</button>
              <button class="btn delete" data-id="${comment.id}" style="padding:4px 8px;">삭제</button>
            </div>`
            : ""
    }
    `;
    commentList.appendChild(wrapper);

    // 수정
    const editBtn = wrapper.querySelector(".btn.edit");
    if (editBtn) {
      editBtn.addEventListener("click", () => editComment(comment.id, comment.content));
    }

    // 삭제
    const deleteBtn = wrapper.querySelector(".btn.delete");
    if (deleteBtn) {
      deleteBtn.addEventListener("click", () => deleteComment(comment.id));
    }
  }

  /* ==============================================
     ✅ 댓글 작성
     ============================================== */
  commentForm.addEventListener("submit", async (e) => {
    e.preventDefault();
    if (!currentUser) return alert("로그인 후 이용해주세요.");

    const content = commentInput.value.trim();
    if (!content) return alert("댓글 내용을 입력해주세요.");

    try {
      const res = await fetch(`/api/comments/${postId}`, {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ content }),
      });
      if (!res.ok) throw new Error("댓글 등록 실패");
      commentInput.value = "";
      await loadComments();
    } catch (err) {
      console.error(err);
      alert("❌ 댓글 등록 중 오류가 발생했습니다.");
    }
  });

  /* ==============================================
     ✅ 댓글 수정
     ============================================== */
  async function editComment(commentId, oldContent) {
    const newContent = prompt("댓글을 수정하세요:", oldContent);
    if (newContent === null || newContent.trim() === "" || newContent === oldContent) return;

    try {
      const res = await fetch(`/api/comments/${commentId}`, {
        method: "PATCH",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ content: newContent }),
      });
      if (!res.ok) throw new Error("댓글 수정 실패");
      await loadComments();
    } catch (err) {
      console.error(err);
      alert("❌ 댓글 수정 중 오류가 발생했습니다.");
    }
  }

  /* ==============================================
     ✅ 댓글 삭제
     ============================================== */
  async function deleteComment(commentId) {
    if (!confirm("댓글을 삭제하시겠습니까?")) return;

    try {
      const res = await fetch(`/api/comments/${commentId}`, { method: "DELETE" });
      if (!res.ok) throw new Error("댓글 삭제 실패");
      await loadComments();
    } catch (err) {
      console.error(err);
      alert("❌ 댓글 삭제 중 오류가 발생했습니다.");
    }
  }

  /* ==============================================
     ✅ 좋아요 버튼 갱신
     ============================================== */
  function updateLikeButton(count, liked) {
    likeBtn.textContent = `❤️ ${count}`;
    if (liked) likeBtn.classList.add("liked");
    else likeBtn.classList.remove("liked");
  }
});
