document.addEventListener("DOMContentLoaded", async () => {
  // header/footer include
  fetch("header.html").then(res => res.text()).then(html => {
    document.getElementById("header-placeholder").innerHTML = html;
  });
  fetch("footer.html").then(res => res.text()).then(html => {
    document.getElementById("footer-placeholder").innerHTML = html;
  });

  const listContainer = document.getElementById("communityPostList");

  try {
    const res = await fetch("/api/community-posts");
    if (!res.ok) throw new Error("게시글 불러오기 실패");
    const data = await res.json();

    listContainer.innerHTML = data.content
    .map(post => `
        <div class="community-item" onclick="location.href='community-detail.html?id=${post.id}'">
          <div class="text">
            <h3 class="title">${post.title}</h3>
            <p class="desc">${(post.description || '').length > 50
        ? post.description.slice(0, 50) + "..."
        : post.description}</p>
            <div class="meta">
              💬 ${post.commentCount} · ${new Date(post.createdAt).toLocaleTimeString("ko-KR", { hour: "2-digit", minute: "2-digit" })} · 익명
            </div>
          </div>
          ${post.imageUrls && post.imageUrls.length > 0
        ? `<img class="thumb" src="${post.imageUrls[0]}" alt="thumbnail">`
        : ""}
        </div>
      `)
    .join("");
  } catch (err) {
    console.error(err);
    listContainer.innerHTML = `<p>❌ 게시글을 불러오는 중 오류가 발생했습니다.</p>`;
  }
});
