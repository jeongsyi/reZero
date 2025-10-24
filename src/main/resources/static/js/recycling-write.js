window.addEventListener("DOMContentLoaded", async () => {
    await loadLayout();
    checkAdminAccess();
    await loadCategories();

    document.getElementById("thumbNailImage").addEventListener("change", previewThumbnail);
    document.getElementById("images").addEventListener("change", previewImages);
    document.getElementById("recyclingForm").addEventListener("submit", handleSubmit);
});

function checkAdminAccess() {
    const isLoggedIn = localStorage.getItem("isLoggedIn") === "true";
    const role = localStorage.getItem("role");
    if (!isLoggedIn || role !== "ADMIN") {
        alert("관리자만 글을 작성할 수 있습니다.");
        window.location.href = "/recycling/recycling.html";
    }
}

async function loadCategories() {
    const res = await fetch("/api/category");
    if (!res.ok) return;

    const categories = await res.json();
    const select = document.getElementById("category");

    categories.forEach(c => {
        const option = document.createElement("option");
        option.value = c.category;
        option.textContent = c.category;
        select.appendChild(option);
    });
}

function previewThumbnail(e) {
    const file = e.target.files[0];
    const preview = document.getElementById("thumbnailPreview");
    if (!file) return;
    preview.src = URL.createObjectURL(file);
    preview.style.display = "block";
}

function previewImages(e) {
    const container = document.getElementById("imagePreviewContainer");
    container.innerHTML = "";
    Array.from(e.target.files).forEach(file => {
        const img = document.createElement("img");
        img.src = URL.createObjectURL(file);
        container.appendChild(img);
    });
}

async function handleSubmit(e) {
    e.preventDefault();
    const errorMsg = document.getElementById("errorMsg");
    errorMsg.textContent = "";

    const title = document.getElementById("title").value.trim();
    const description = document.getElementById("description").value.trim();
    const categoryId = document.getElementById("category").value;
    const thumbNailFile = document.getElementById("thumbNailImage").files[0];
    const imageFiles = document.getElementById("images").files;

    if (!title || !description || !categoryId || !thumbNailFile) {
        errorMsg.textContent = "모든 필수 항목을 입력해주세요.";
        return;
    }

    const requestData = {
        title,
        description,
        thumbNailImage: thumbNailFile.name, // 서버에서 URL로 변환할 예정
        categoryId: Number(categoryId)
    };

    const formData = new FormData();
    formData.append("request", new Blob([JSON.stringify(requestData)], { type: "application/json" }));
    Array.from(imageFiles).forEach(f => formData.append("images", f));

    try {
        const res = await fetch("/api/recycling-posts", {
            method: "POST",
            body: formData,
        });

        if (!res.ok) {
            const text = await res.text();
            throw new Error(text || "등록 실패");
        }

        alert("게시글이 성공적으로 등록되었습니다!");
        window.location.href = "/recycling/recycling.html";
    } catch (err) {
        console.error(err);
        errorMsg.textContent = "등록 중 오류가 발생했습니다.";
    }
}
