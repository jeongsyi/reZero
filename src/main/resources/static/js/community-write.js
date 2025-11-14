document.addEventListener("DOMContentLoaded", () => {
  // ✅ Header/Footer include
  fetch("header.html").then(res => res.text()).then(html => {
    document.getElementById("header-placeholder").innerHTML = html;
  });
  fetch("footer.html").then(res => res.text()).then(html => {
    document.getElementById("footer-placeholder").innerHTML = html;
  });

  const imageInput = document.getElementById("images");
  const previewContainer = document.getElementById("imagePreview");

  // ✅ 미리보기 (첫 번째 이미지는 썸네일 강조)
  imageInput.addEventListener("change", () => {
    previewContainer.innerHTML = "";
    const files = Array.from(imageInput.files);
    if (files.length === 0) return;

    files.forEach((file, index) => {
      const reader = new FileReader();
      reader.onload = e => {
        const img = document.createElement("img");
        img.src = e.target.result;
        img.alt = "preview";
        if (index === 0) img.style.border = "3px solid #639c67"; // 썸네일 표시
        previewContainer.appendChild(img);
      };
      reader.readAsDataURL(file);
    });
  });

  // ✅ 글 등록
  document.getElementById("missionForm").addEventListener("submit", async e => {
    e.preventDefault();

    const title = document.getElementById("title").value.trim();
    const description = document.getElementById("description").value.trim();
    const files = imageInput.files;

    if (!title || !description) {
      alert("제목과 내용을 모두 입력해주세요.");
      return;
    }
    if (!files.length) {
      alert("사진 인증은 필수입니다.");
      return;
    }

    const formData = new FormData();
    const requestData = {
      missionId: 1, // ✅ 현재 활성화된 미션 1개만 존재한다고 가정 (백엔드에서 active mission 검색)
      title,
      description
    };

    // ✅ Spring Controller의 @RequestPart("data")와 맞춤
    formData.append("data", new Blob([JSON.stringify(requestData)], { type: "application/json" }));
    for (let file of files) {
      formData.append("images", file);
    }

    try {
      const res = await fetch("/api/mission-posts", {
        method: "POST",
        body: formData
      });

      if (res.ok) {
        alert("✅ 미션 인증글이 등록되었습니다! 검토 후 승인됩니다.");
        window.location.href = "community.html";
      } else {
        const text = await res.text();
        console.error("등록 실패:", text);
        alert("❌ 글 등록에 실패했습니다. 사진과 내용을 확인해주세요.");
      }
    } catch (err) {
      console.error(err);
      alert("❌ 서버 오류가 발생했습니다.");
    }
  });
});
