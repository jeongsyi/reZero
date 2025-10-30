document.addEventListener("DOMContentLoaded", async () => {
  // ✅ Header / Footer include
  fetch("header.html").then(res => res.text()).then(html => {
    document.getElementById("header-placeholder").innerHTML = html;
  });
  fetch("footer.html").then(res => res.text()).then(html => {
    document.getElementById("footer-placeholder").innerHTML = html;
  });

  const postId = new URLSearchParams(window.location.search).get("id");
  const detailContainer = document.getElementById("communityDetail");
  const postActions = document.getElementById("postActions");
  const likeBtn = document.getElementById("likeBtn");

  let postData = null;
  let currentUser = null;
  let liked = false;

  try {
    // ✅ 게시글 데이터 불러오기
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

    // ✅ 로그인 사용자 정보 불러오기
    const userRes = await fetch("/api/me");
    if (userRes.ok) {
      currentUser = await userRes.json();
      if (currentUser.name === postData.userName) postActions.style.display = "flex";

      const likeCheckRes = await fetch(`/api/likes?postId=${postId}`);
      if (likeCheckRes.ok) {
        const likePage = await likeCheckRes.json();
        liked = likePage.content?.some(l => l.postId === Number(postId)) || false;
      }
    }

    updateLikeButton(postData.likeCount, liked);
    await initComments(postId, currentUser);
  } catch (err) {
    console.error(err);
    detailContainer.innerHTML = `<p>❌ 게시글을 불러오는 중 오류가 발생했습니다.</p>`;
  }

  // ✅ 좋아요 처리
  likeBtn.addEventListener("click", async () => {
    if (!currentUser) return alert("로그인 후 이용해주세요.");
    try {
      if (!liked) {
        await fetch(`/api/likes/${postId}`, { method: "POST" });
        liked = true;
        postData.likeCount++;
      } else {
        await fetch(`/api/likes/${postId}`, { method: "DELETE" });
        liked = false;
        postData.likeCount--;
      }
      updateLikeButton(postData.likeCount, liked);
    } catch {
      alert("❌ 좋아요 처리 중 오류 발생");
    }
  });

  function updateLikeButton(count, liked) {
    likeBtn.textContent = `❤️ ${count}`;
    likeBtn.classList.toggle("liked", liked);
  }

  // ✅ 수정/삭제 버튼
  document.getElementById("editBtn").addEventListener("click", () => {
    const query = new URLSearchParams({
      id: postData.id,
      title: postData.title,
      description: postData.description
    });
    location.href = `community-edit.html?${query.toString()}`;
  });

  document.getElementById("deleteBtn").addEventListener("click", async () => {
    if (!confirm("정말로 이 글을 삭제하시겠습니까?")) return;
    await fetch(`/api/community-posts/${postData.id}`, { method: "DELETE" });
    alert("삭제 완료");
    location.href = "community.html";
  });
});

// ✅ 댓글 기능
async function initComments(postId, currentUser) {
  let nextCursor = null;
  let nextIdAfter = null;
  let sortDirection = "desc";
  const size = 15;
  const commentList = document.getElementById("comment-list");
  const loadMoreBtn = document.getElementById("load-more-btn");
  const sortSelect = document.getElementById("sort-select");

  async function loadComments(reset = false) {
    try {
      let url = `/api/comments/${postId}?sortDirection=${sortDirection}&size=${size}`;
      if (nextCursor && nextIdAfter) {
        url += `&cursor=${encodeURIComponent(nextCursor)}&idAfter=${encodeURIComponent(nextIdAfter)}`;
      }

      const res = await fetch(url);
      if (!res.ok) throw new Error("댓글 불러오기 실패");

      const data = await res.json();
      const comments = Array.isArray(data.content) ? data.content : [];

      if (reset) commentList.innerHTML = "";

      if (comments.length === 0) {
        commentList.innerHTML = `<p style="text-align:center;color:#777;">댓글이 없습니다.</p>`;
        loadMoreBtn.style.display = "none";
        return;
      }

      comments.forEach(c => {
        renderComment(c);
        if (c.children?.length) {
          c.children.forEach(child => renderComment(child, true, c.id));
        }
      });

      nextCursor = data.nextCursor;
      nextIdAfter = data.nextIdAfter;
      loadMoreBtn.style.display = data.hasNext ? "block" : "none";
    } catch (err) {
      console.error("댓글 로드 오류:", err);
    }
  }

  function renderComment(comment, isReply = false, parentId = null) {
    const div = document.createElement("div");
    div.className = isReply ? "comment reply" : "comment";
    div.setAttribute("data-id", comment.id);

    const isMine = currentUser && currentUser.name === comment.userName;
    const profileUrl = comment.profileUrl && comment.profileUrl !== ""
        ? comment.profileUrl
        : "/images/default-profile.png";

    div.innerHTML = `
      <div class="comment-header">
        <div class="comment-profile">
          <img src="${profileUrl}" alt="프로필 이미지" style="cursor:pointer"
               onclick="location.href='/user-profile.html?id=${comment.userId}'">
        </div>
        <div class="comment-info">
          <div class="user-name">${comment.userName}</div>
          <div class="meta">${new Date(comment.createdAt).toLocaleString()}</div>
        </div>
      </div>
      <div class="content">${comment.content}</div>
      <div class="comment-actions">
        ${!isReply ? `<button class="reply-btn">답글</button>` : ""}
        ${isMine ? `<button class="edit-btn">수정</button><button class="delete-btn">삭제</button>` : ""}
      </div>
      <div class="reply-list"></div>
    `;

    if (isReply && parentId) {
      const parent = document.querySelector(`.comment[data-id="${parentId}"] .reply-list`);
      (parent || commentList).appendChild(div);
    } else {
      commentList.appendChild(div);
    }

    setupCommentActions(div, comment, isReply);
  }

  function setupCommentActions(div, comment, isReply) {
    const replyBtn = div.querySelector(".reply-btn");
    const editBtn = div.querySelector(".edit-btn");
    const deleteBtn = div.querySelector(".delete-btn");

    if (replyBtn) {
      replyBtn.addEventListener("click", () => toggleReplyForm(div, comment.id));
    }

    // ✅ 수정 기능
    if (editBtn) {
      editBtn.addEventListener("click", async () => {
        const contentEl = div.querySelector(".content");
        if (!contentEl) return;

        const old = contentEl.textContent.trim();
        if (div.querySelector(".edit-area")) return;

        const editBox = document.createElement("div");
        editBox.className = "edit-area";
        editBox.innerHTML = `
          <textarea class="edit-text">${old}</textarea>
          <div class="edit-btns">
            <button class="save-edit">저장</button>
            <button class="cancel-edit">취소</button>
          </div>
        `;
        contentEl.replaceWith(editBox);

        const saveBtn = editBox.querySelector(".save-edit");
        const cancelBtn = editBox.querySelector(".cancel-edit");
        const textArea = editBox.querySelector(".edit-text");

        saveBtn.addEventListener("click", async () => {
          const newContent = textArea.value.trim();
          if (!newContent) return alert("내용을 입력하세요.");

          try {
            const res = await fetch(`/api/comments/${comment.id}`, {
              method: "PATCH",
              headers: { "Content-Type": "application/json" },
              body: JSON.stringify({ content: newContent })
            });

            if (res.ok) {
              const newDiv = document.createElement("div");
              newDiv.className = "content";
              newDiv.textContent = newContent;
              editBox.replaceWith(newDiv);
            } else {
              alert("❌ 수정 실패");
            }
          } catch (err) {
            alert("⚠️ 서버 오류 발생");
            console.error(err);
          }
        });

        cancelBtn.addEventListener("click", () => {
          editBox.replaceWith(contentEl);
        });
      });
    }

    // ✅ 삭제 기능
    if (deleteBtn) {
      deleteBtn.addEventListener("click", async () => {
        if (!confirm("댓글을 삭제하시겠습니까?")) return;
        const res = await fetch(`/api/comments/${comment.id}`, { method: "DELETE" });
        if (res.ok) div.remove();
      });
    }
  }

  function toggleReplyForm(parentDiv, parentId) {
    const existing = parentDiv.querySelector(".reply-form");
    if (existing) return existing.remove();

    const form = document.createElement("div");
    form.className = "reply-form";
    form.innerHTML = `
      <textarea placeholder="답글을 입력하세요"></textarea>
      <button>등록</button>
    `;
    parentDiv.appendChild(form);

    const textarea = form.querySelector("textarea");
    const button = form.querySelector("button");

    button.addEventListener("click", async () => {
      const content = textarea.value.trim();
      if (!content) return alert("답글 내용을 입력하세요.");

      const res = await fetch(`/api/comments/${postId}`, {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ content, parentId }),
      });

      if (res.ok) {
        const reply = await res.json();
        renderComment(reply, true, parentId);
        form.remove();
      } else alert("답글 등록 실패");
    });
  }

  // ✅ 새 댓글 작성
  document.getElementById("submit-comment").addEventListener("click", async () => {
    const content = document.getElementById("new-comment-content").value.trim();
    if (!content) return alert("댓글 내용을 입력하세요.");

    const res = await fetch(`/api/comments/${postId}`, {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({ content }),
    });

    if (res.ok) {
      const newComment = await res.json();
      renderComment(newComment);
      document.getElementById("new-comment-content").value = "";
    } else alert("댓글 등록 실패");
  });

  // ✅ 정렬 변경 시
  sortSelect.addEventListener("change", async e => {
    sortDirection = e.target.value;
    nextCursor = null;
    nextIdAfter = null;
    await loadComments(true);
  });

  // ✅ 더보기 버튼
  loadMoreBtn.addEventListener("click", async () => await loadComments(false));

  await loadComments(true);
}
