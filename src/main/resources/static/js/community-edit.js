document.addEventListener("DOMContentLoaded", async () => {
  // ✅ Header/Footer 로드
  fetch("header.html").then(res => res.text()).then(html => {
    document.getElementById("header-placeholder").innerHTML = html;
  });
  fetch("footer.html").then(res => res.text()).then(html => {
    document.getElementById("footer-placeholder").innerHTML = html;
  });

  // ✅ URL 파라미터에서 데이터 추출
  const params = new URLSearchParams(window.location.search);
  const postId = params.get("id");
  document.getElementById("title").value = params.get("title") || "";
  document.getElementById("description").value = params.get("description") || "";

  // ✅ 이미지 미리보기
  const imageInput = document.getElementById("images");
  const preview = document.getElementById("imagePreview");

  imageInput.addEventListener("change", () => {
    preview.innerHTML = "";
    Array.from(imageInput.files).forEach(file => {
      const reader = new FileReader();
      reader.onload = e => {
        const img = document.createElement("img");
        img.src = e.target.result;
        preview.appendChild(img);
      };
      reader.readAsDataURL(file);
    });
  });

  // ✅ 폼 제출 (PATCH)
  document.getElementById("editForm").addEventListener("submit", async e => {
    e.preventDefault();

    const title = document.getElementById("title").value.trim();
    const description = document.getElementById("description").value.trim();
    if (!title || !description) return alert("제목과 내용을 입력해주세요.");

    // ✅ 서버는 @RequestPart("data") 를 받으므로 이름을 data로 설정해야 함
    const formData = new FormData();
    formData.append(
        "data",
        new Blob(
            [JSON.stringify({ missionId: null, title, description })],
            { type: "application/json" }
        )
    );
    for (const file of imageInput.files) {
      formData.append("images", file);
    }

    try {
      const res = await fetch(`/api/mission-posts/${postId}`, {
        method: "PATCH",
        body: formData
      });

      if (!res.ok) throw new Error("수정 실패");
      alert("✅ 게시글이 수정되었습니다.");
      location.href = `community-detail.html?id=${postId}`;
    } catch (err) {
      alert("❌ 수정 중 오류가 발생했습니다.");
      console.error(err);
    }
  });
});
