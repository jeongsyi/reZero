window.addEventListener("DOMContentLoaded", async () => {
    await loadLayout();
    await loadPostDetail();
    await initComments();
});

/* -------------------------------------------------
   게시글 상세 불러오기
------------------------------------------------- */
async function loadPostDetail() {
    const postId = new URLSearchParams(window.location.search).get("id");
    if (!postId) {
        document.body.innerHTML = "<p>잘못된 접근입니다.</p>";
        return;
    }

    try {
        const res = await fetch(`/api/recycling-posts/${postId}`);
        if (!res.ok) throw new Error("게시글 불러오기 실패");

        const post = await res.json();

        document.getElementById("post-title").textContent = post.title;
        document.getElementById("post-meta").textContent =
            `${post.userName || "익명"} · ${formatDate(post.createdAt)} · ${post.category || "카테고리 없음"}`;

        const thumbnail = document.getElementById("thumbnail");
        thumbnail.src =
            post.thumbNailImageUrl && post.thumbNailImageUrl !== ""
                ? post.thumbNailImageUrl
                : "/images/default-thumb.jpg";

        document.getElementById("post-description").textContent = post.description || "내용이 없습니다.";
    } catch (e) {
        console.error("상세 불러오기 오류:", e);
        document.querySelector(".recycling-detail").innerHTML =
            "<p>게시글을 불러오는 중 오류가 발생했습니다.</p>";
    }
}

/* -------------------------------------------------
   댓글 기능 (커서 기반)
------------------------------------------------- */
async function initComments() {
    const postId = new URLSearchParams(window.location.search).get("id");
    if (!postId) return;

    let nextCursor = null;
    let nextIdAfter = null;
    let isLoading = false;
    let sortDirection = "asc";
    const size = 20;

    const commentList = document.getElementById("comment-list");
    const loadMoreBtn = document.getElementById("load-more-btn");
    const sortSelect = document.getElementById("sort-select");

    // ✅ 댓글 불러오기
    async function loadComments(reset = false) {
        if (isLoading) return;
        isLoading = true;

        try {
            let url = `/api/qna-comments/${postId}?sortDirection=${sortDirection}&size=${size}`;
            if (nextCursor && nextIdAfter) {
                url += `&cursor=${encodeURIComponent(nextCursor)}&idAfter=${encodeURIComponent(nextIdAfter)}`;
            }

            const res = await fetch(url);
            if (!res.ok) throw new Error("댓글 로드 실패");

            const data = await res.json();
            const comments = Array.isArray(data) ? data : data.content || data.items;

            if (reset) commentList.innerHTML = "";

            if (!comments || comments.length === 0) {
                if (reset) commentList.innerHTML = "<p style='text-align:center; color:#666;'>댓글이 없습니다.</p>";
                loadMoreBtn.style.display = "none";
                return;
            }

            comments.forEach((c) => {
                renderComment(c);
                if (c.children?.length) {
                    c.children.forEach((child) => renderComment(child, true, c.id));
                }
            });

            nextCursor = data.nextCursor ?? null;
            nextIdAfter = data.nextIdAfter ?? null;
            loadMoreBtn.style.display = data.hasNext ? "block" : "none";

        } catch (err) {
            console.error("댓글 불러오기 오류:", err);
        } finally {
            isLoading = false;
        }
    }

    function renderComment(comment, isReply = false, parentId = null) {
        const div = document.createElement("div");
        div.className = isReply ? "comment reply" : "comment";
        div.setAttribute("data-id", comment.id);

        const currentUserId = localStorage.getItem("userId"); // ✅ 로그인된 사용자 ID (백엔드 로그인 시 저장)
        const isMine = comment.userId && currentUserId && comment.userId === currentUserId; // ✅ 본인 댓글 여부

        const profileUrl =
            comment.profileUrl && comment.profileUrl.startsWith("http")
                ? comment.profileUrl
                : comment.profileUrl
                    ? `/uploads/${comment.profileUrl}`
                    : "/images/default-profile.png";

        div.innerHTML = `
        <div class="comment-header">
            <div class="comment-profile">
                <img src="${profileUrl}" alt="profile">
            </div>
            <div class="comment-info">
                <div class="user-name">${comment.userName}</div>
                <div class="meta">${new Date(comment.createdAt).toLocaleString()}</div>
            </div>
            <div class="comment-actions">
                ${
            !isReply
                ? `<button class="reply-icon" title="답글"><i class="fa-regular fa-comment-dots"></i></button>`
                : ""
        }
                ${
            isMine
                ? `
                            <button class="more-icon" title="옵션"><i class="fa-solid fa-ellipsis-vertical"></i></button>
                            <div class="more-menu hidden">
                                <button class="edit-btn">수정</button>
                                <button class="delete-btn">삭제</button>
                            </div>
                        `
                : "" // ✅ 내가 쓴 댓글이 아니면 점 세 개 안 보임
        }
            </div>
        </div>
        <div class="content" data-id="${comment.id}">${comment.content}</div>
        <div class="reply-list"></div>
    `;

        if (isReply && parentId) {
            const parentDiv = document.querySelector(`.comment[data-id="${parentId}"] .reply-list`);
            (parentDiv || commentList).appendChild(div);
        } else {
            commentList.appendChild(div);
        }

        setupCommentActions(div, comment, isReply);
    }


    // ✅ 댓글 액션
    function setupCommentActions(div, comment, isReply) {
        const moreIcon = div.querySelector(".more-icon");
        const moreMenu = div.querySelector(".more-menu");

        moreIcon?.addEventListener("click", (e) => {
            document.querySelectorAll(".more-menu").forEach((m) => m.classList.add("hidden"));
            moreMenu.classList.toggle("hidden");
            e.stopPropagation();
        });

        document.addEventListener("click", () => {
            document.querySelectorAll(".more-menu").forEach((m) => m.classList.add("hidden"));
        });

        // 수정
        div.querySelector(".edit-btn")?.addEventListener("click", () => {
            const contentEl = div.querySelector(".content");
            const original = contentEl.textContent.trim();
            contentEl.innerHTML = `
                <textarea class="edit-area">${original}</textarea>
                <div class="edit-btns">
                    <button class="save-edit">저장</button>
                    <button class="cancel-edit">취소</button>
                </div>
            `;
            const saveBtn = contentEl.querySelector(".save-edit");
            const cancelBtn = contentEl.querySelector(".cancel-edit");

            saveBtn.addEventListener("click", async () => {
                const newText = contentEl.querySelector(".edit-area").value.trim();
                if (!newText) return alert("내용을 입력하세요.");

                const res = await fetch(`/api/qna-comments/${comment.id}`, {
                    method: "PATCH",
                    headers: {"Content-Type": "application/json"},
                    body: JSON.stringify({content: newText}),
                });

                if (res.ok) contentEl.textContent = newText;
                else {
                    alert("수정 실패");
                    contentEl.textContent = original;
                }
            });

            cancelBtn.addEventListener("click", () => (contentEl.textContent = original));
        });

        // 삭제
        div.querySelector(".delete-btn")?.addEventListener("click", async () => {
            if (!confirm("이 댓글을 삭제하시겠습니까?")) return;
            const res = await fetch(`/api/qna-comments/${comment.id}`, {method: "DELETE"});
            if (res.ok) div.remove();
            else alert("삭제 실패");
        });

        // 답글
        if (!isReply) {
            div.querySelector(".reply-icon")?.addEventListener("click", () => {
                toggleReplyForm(div, comment.id);
            });
        }
    }

    // ✅ 대댓글 입력창
    function toggleReplyForm(parentDiv, parentId) {
        const existingForm = parentDiv.querySelector(".reply-form");
        if (existingForm) return existingForm.remove();

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

            const res = await fetch(`/api/qna-comments/${postId}`, {
                method: "POST",
                headers: {"Content-Type": "application/json"},
                body: JSON.stringify({content, parentId}),
            });

            if (res.ok) {
                const reply = await res.json();
                renderComment(reply, true, parentId);
                form.remove();
            } else alert("답글 등록 실패");
        });
    }

    // ✅ 새 댓글 등록
    document.getElementById("submit-comment")?.addEventListener("click", async () => {
        const textarea = document.getElementById("new-comment-content");
        const content = textarea.value.trim();
        if (!content) return alert("댓글 내용을 입력하세요.");

        try {
            const res = await fetch(`/api/qna-comments/${postId}`, {
                method: "POST",
                headers: {"Content-Type": "application/json"},
                body: JSON.stringify({content}),
            });

            if (res.ok) {
                const newComment = await res.json();
                renderComment(newComment, false);
                textarea.value = "";
            } else alert("댓글 등록 실패");
        } catch (err) {
            console.error("댓글 등록 오류:", err);
        }
    });

    // ✅ 정렬 변경
    sortSelect?.addEventListener("change", async (e) => {
        sortDirection = e.target.value;
        nextCursor = null;
        nextIdAfter = null;
        await loadComments(true);
    });

    // ✅ 더보기 버튼 클릭
    loadMoreBtn?.addEventListener("click", async () => {
        if (!isLoading && nextCursor) {
            await loadComments(false);
        }
    });

    // ✅ 초기 로드
    await loadComments(true);
}

/* -------------------------------------------------
   공통 함수
------------------------------------------------- */
function goBack() {
    window.location.href = "/recycling-list.html";
}

function formatDate(dateStr) {
    if (!dateStr) return "";
    const d = new Date(dateStr);
    return d.toLocaleDateString("ko-KR", {year: "numeric", month: "short", day: "numeric"});
}
