document.addEventListener("DOMContentLoaded", () => {
  // header/footer include
  fetch("header.html").then(res => res.text()).then(html => {
    document.getElementById("header-placeholder").innerHTML = html;
  });
  fetch("footer.html").then(res => res.text()).then(html => {
    document.getElementById("footer-placeholder").innerHTML = html;
  });

  const imageInput = document.getElementById("images");
  const previewContainer = document.getElementById("imagePreview");

  // 미리보기 (첫 번째 이미지 = 썸네일)
  imageInput.addEventListener("change", () => {
    previewContainer.innerHTML = "";
    const files = Array.from(imageInput.files);
    files.forEach((file, index) => {
      const reader = new FileReader();
      reader.onload = e => {
        const img = document.createElement("img");
        img.src = e.target.result;
        img.alt = "preview";
        if (index === 0) img.style.border = "3px solid #639c67"; // 썸네일 강조
        previewContainer.appendChild(img);
      };
      reader.readAsDataURL(file);
    });
  });

  // 폼 제출
  document.getElementById("communityForm").addEventListener("submit", async e => {
    e.preventDefault();

    const title = document.getElementById("title").value.trim();
    const description = document.getElementById("description").value.trim();
    if (!title || !description) {
      alert("제목과 내용을 모두 입력해주세요.");
      return;
    }

    const formData = new FormData();
    const requestData = { title, description };
    formData.append("request", new Blob([JSON.stringify(requestData)], { type: "application/json" }));

    const files = imageInput.files;
    for (let file of files) formData.append("images", file);

    try {
      const res = await fetch("/api/community-posts", {
        method: "POST",
        body: formData
      });

      if (!res.ok) throw new Error("등록 실패");
      alert("✅ 글이 등록되었습니다!");
      window.location.href = "community.html";
    } catch (err) {
      console.error(err);
      alert("❌ 글 등록 중 오류가 발생했습니다.");
    }
  });
});
