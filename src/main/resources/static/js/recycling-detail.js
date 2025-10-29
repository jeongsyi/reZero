window.addEventListener("DOMContentLoaded", async () => {
    await loadLayout();
    await loadPostDetail();
    await initComments();
});

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

        // 제목
        document.getElementById("post-title").textContent = post.title;

        // ✅ postUserInfo에만 텍스트 넣기 (덮어쓰기 금지)
        const postUserInfo = document.getElementById("postUserInfo");
        postUserInfo.textContent =
            `${post.userName || "익명"} · ${formatDate(post.createdAt)} · ${post.category || "카테고리 없음"}`;

        // 썸네일
        const thumbnail = document.getElementById("thumbnail");
        thumbnail.src =
            post.thumbNailImageUrl && post.thumbNailImageUrl !== ""
                ? post.thumbNailImageUrl
                : "/images/default-thumb.jpg";

        document.getElementById("post-description").textContent =
            post.description || "내용이 없습니다.";

        // ✅ 작성자 본인만 점 세개 표시
        const postActions = document.getElementById("postActions");
        const moreIcon = document.getElementById("postMoreIcon");
        const moreMenu = document.getElementById("postMoreMenu");
        const editBtn = document.getElementById("editPostBtn");
        const deleteBtn = document.getElementById("deletePostBtn");

        const currentUserId = localStorage.getItem("userId");
        if (currentUserId && post.userId && currentUserId === String(post.userId)) {
            postActions.style.display = "flex";
        } else {
            postActions.style.display = "none";
        }

        // 점 버튼 클릭 이벤트
        moreIcon.addEventListener("click", (e) => {
            e.stopPropagation();
            moreMenu.classList.toggle("hidden");
        });
        document.addEventListener("click", () => {
            moreMenu.classList.add("hidden");
        });

        // 수정 버튼
        editBtn.addEventListener("click", () => {
            window.location.href = `/recycling-edit.html?id=${postId}`;
        });

        // 삭제 버튼
        deleteBtn.addEventListener("click", async () => {
            if (!confirm("정말 삭제하시겠습니까?")) return;
            const res = await fetch(`/api/recycling-posts/${postId}`, { method: "DELETE" });
            if (res.ok) {
                alert("게시글이 삭제되었습니다.");
                window.location.href = "/recycling-list.html";
            } else {
                alert("삭제 중 오류가 발생했습니다.");
            }
        });

        // 스크랩 버튼 세팅
        await setupScrapButton(postId);
    } catch (e) {
        console.error("상세 불러오기 오류:", e);
        document.querySelector(".recycling-detail").innerHTML =
            "<p>게시글을 불러오는 중 오류가 발생했습니다.</p>";
    }
}

async function setupScrapButton(postId) {
    const scrapBtn = document.getElementById("scrapBtn");
    if (!scrapBtn) return;

    const isLoggedIn = localStorage.getItem("isLoggedIn") === "true";

    // ✅ 버튼은 항상 보이게
    scrapBtn.style.display = "inline-flex";
    let scrapped = false;
    let scrapCount = 0;

    try {
        // ✅ 로그인된 경우에만 스크랩 상태 조회
        if (isLoggedIn) {
            const checkRes = await fetch(`/api/scraps`);
            if (checkRes.ok) {
                const data = await checkRes.json();
                const scraps = data.content || [];
                scrapped = scraps.some((s) => s.postId === Number(postId));
            }
        }

        // ✅ 게시글 자체의 scrapCount는 로그인 여부 상관없이 조회
        const postRes = await fetch(`/api/recycling-posts/${postId}`);
        if (postRes.ok) {
            const postData = await postRes.json();
            scrapCount = postData.scrapCount || 0;
        }

        updateScrapButton(scrapBtn, scrapped, scrapCount);
    } catch (err) {
        console.error("스크랩 상태 조회 실패:", err);
        updateScrapButton(scrapBtn, false, scrapCount);
    }

    // ✅ 클릭 이벤트 처리
    scrapBtn.addEventListener("click", async () => {
        // 🔒 로그인 안 된 상태면 알림만
        if (!isLoggedIn) {
            alert("스크랩하려면 로그인이 필요합니다.");
            return;
        }

        try {
            let res;
            if (!scrapped) {
                res = await fetch(`/api/scraps/${postId}`, { method: "POST" });
                if (!res.ok) throw new Error("스크랩 실패");
                scrapped = true;
                scrapCount++;
            } else {
                res = await fetch(`/api/scraps/${postId}`, { method: "DELETE" });
                if (!res.ok) throw new Error("스크랩 취소 실패");
                scrapped = false;
                scrapCount = Math.max(scrapCount - 1, 0);
            }
            updateScrapButton(scrapBtn, scrapped, scrapCount);
        } catch (e) {
            console.error("스크랩 처리 중 오류:", e);
            alert("스크랩 처리 중 오류가 발생했습니다.");
        }
    });
}

function updateScrapButton(btn, isActive, count) {
    btn.classList.toggle("active", isActive);
    btn.innerHTML = isActive
        ? ` ⭐ <span>${count}</span>`
        : ` ⭐ <span>${count}</span>`;
}

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

        const currentUserId = localStorage.getItem("userId");
        const isMine = comment.userId && currentUserId && comment.userId === currentUserId;

        const profileUrl =
            comment.profileUrl && comment.profileUrl.startsWith("http")
                ? comment.profileUrl
                : comment.profileUrl
                    ? `/uploads/${comment.profileUrl}`
                    : "/images/default-profile.png";

        div.innerHTML = `
        <div class="comment-header">
            <div class="comment-profile"><img src="${profileUrl}" alt="profile"></div>
            <div class="comment-info">
                <div class="user-name">${comment.userName}</div>
                <div class="meta">${new Date(comment.createdAt).toLocaleString()}</div>
            </div>
            <div class="comment-actions">
                ${!isReply ? `<button class="reply-icon"><i class="fa-regular fa-comment-dots"></i></button>` : ""}
                ${isMine
            ? `<button class="more-icon"><i class="fa-solid fa-ellipsis-vertical"></i></button>
                   <div class="more-menu hidden">
                       <button class="edit-btn">수정</button>
                       <button class="delete-btn">삭제</button>
                   </div>`
            : ""}
            </div>
        </div>
        <div class="content" data-id="${comment.id}">${comment.content}</div>
        <div class="reply-list"></div>`;

        if (isReply && parentId) {
            const parentDiv = document.querySelector(`.comment[data-id="${parentId}"] .reply-list`);
            (parentDiv || commentList).appendChild(div);
        } else {
            commentList.appendChild(div);
        }

        setupCommentActions(div, comment, isReply);
    }

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

        div.querySelector(".edit-btn")?.addEventListener("click", () => {
            const contentEl = div.querySelector(".content");
            const original = contentEl.textContent.trim();
            contentEl.innerHTML = `
                <textarea class="edit-area">${original}</textarea>
                <div class="edit-btns">
                    <button class="save-edit">저장</button>
                    <button class="cancel-edit">취소</button>
                </div>`;
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

        div.querySelector(".delete-btn")?.addEventListener("click", async () => {
            if (!confirm("이 댓글을 삭제하시겠습니까?")) return;
            const res = await fetch(`/api/qna-comments/${comment.id}`, {method: "DELETE"});
            if (res.ok) div.remove();
            else alert("삭제 실패");
        });

        if (!isReply) {
            div.querySelector(".reply-icon")?.addEventListener("click", () => {
                toggleReplyForm(div, comment.id);
            });
        }
    }

    function toggleReplyForm(parentDiv, parentId) {
        const existingForm = parentDiv.querySelector(".reply-form");
        if (existingForm) return existingForm.remove();
        const form = document.createElement("div");
        form.className = "reply-form";
        form.innerHTML = `<textarea placeholder="답글을 입력하세요"></textarea><button>등록</button>`;
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

    sortSelect?.addEventListener("change", async (e) => {
        sortDirection = e.target.value;
        nextCursor = null;
        nextIdAfter = null;
        await loadComments(true);
    });

    loadMoreBtn?.addEventListener("click", async () => {
        if (!isLoading && nextCursor) await loadComments(false);
    });

    await loadComments(true);
}

function goBack() {
    window.location.href = "/recycling-list.html";
}

function formatDate(dateStr) {
    if (!dateStr) return "";
    const d = new Date(dateStr);
    return d.toLocaleDateString("ko-KR", {year: "numeric", month: "short", day: "numeric"});
}
