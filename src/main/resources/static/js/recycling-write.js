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
        window.location.href = "/recycling-list.html";
    }
}

async function loadCategories() {
    const res = await fetch("/api/category");
    const categories = await res.json();

    const select = document.getElementById("category");
    categories.forEach(c => {
        const option = document.createElement("option");
        option.value = c.id || c.categoryId;
        option.textContent = c.category || c.name;
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

let selectedFiles = [];

function previewImages(e) {
    const container = document.getElementById("imagePreviewContainer");
    const newFiles = Array.from(e.target.files);
    selectedFiles = [...selectedFiles, ...newFiles];
    container.innerHTML = "";

    selectedFiles.forEach(file => {
        const reader = new FileReader();
        reader.onload = event => {
            const img = document.createElement("img");
            img.src = event.target.result;
            img.alt = file.name;
            container.appendChild(img);
        };
        reader.readAsDataURL(file);
    });

    const dataTransfer = new DataTransfer();
    selectedFiles.forEach(f => dataTransfer.items.add(f));
    e.target.files = dataTransfer.files;
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
        categoryId: Number(categoryId),
    };

    const formData = new FormData();
    formData.append("request", new Blob([JSON.stringify(requestData)], { type: "application/json" }));
    formData.append("thumbsNailImage", thumbNailFile);
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
        errorMsg.textContent = "등록 중 오류가 발생했습니다.";
    }
}
