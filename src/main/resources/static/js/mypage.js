async function loadLayout() {
  const headerHtml = await fetch("header.html").then(res => res.text());
  const headerPlaceholder = document.getElementById("header-placeholder");
  headerPlaceholder.innerHTML = headerHtml;

  const headerScripts = headerPlaceholder.querySelectorAll("script");
  headerScripts.forEach((oldScript) => {
    const newScript = document.createElement("script");
    if (oldScript.src) newScript.src = oldScript.src;
    else newScript.textContent = oldScript.textContent;
    document.body.appendChild(newScript);
  });

  if (typeof applyLoginState === "function") {
    applyLoginState();
  }

  const footerHtml = await fetch("footer.html").then(res => res.text());
  document.getElementById("footer-placeholder").innerHTML = footerHtml;

  await loadProfile();
}

async function loadProfile() {
  try {
    const res = await fetch("/api/me", { credentials: "include" });
    if (!res.ok) throw new Error(`프로필 요청 실패: ${res.status}`);

    const data = await res.json();
    console.log("✅ Profile data:", data);

    document.getElementById("name").textContent = data.name ?? "-";
    document.getElementById("userId").textContent = data.userId ?? "-";
    document.getElementById("role").textContent = data.role ?? "-";
    document.getElementById("region").textContent = data.region ?? "-";
    document.getElementById("birth").textContent = data.birth ?? "-";
    document.getElementById("profile-image").src =
        data.profileUrl || "/img/default_profile.png";
    document.getElementById("followerCount").textContent =
        data.followerCount ?? 0;
    document.getElementById("followingCount").textContent =
        data.followingCount ?? 0;
  } catch (err) {
    console.error("❌ loadProfile error:", err);
    alert("세션이 만료되었거나 로그인 상태가 아닙니다.");
    window.location.href = "login.html";
  }
}

// === 수정 / 삭제 ===
document.addEventListener("click", async (e) => {
  // === 수정 폼 열기 ===
  if (e.target.id === "edit-btn") {
    const editForm = document.getElementById("edit-form");
    editForm.classList.remove("hidden");

    document.getElementById("edit-userId").value =
        document.getElementById("userId").textContent;
    document.getElementById("edit-name").value =
        document.getElementById("name").textContent;
    document.getElementById("edit-region").value =
        document.getElementById("region").textContent;
    document.getElementById("edit-profileUrl").value =
        document.getElementById("profile-image").src;
  }

  // === 수정 취소 ===
  if (e.target.id === "cancel-edit") {
    document.getElementById("edit-form").classList.add("hidden");
  }

  // === 수정 저장 ===
  if (e.target.id === "save-edit") {
    const updateData = {
      userId: document.getElementById("edit-userId").value.trim(),
      password: document.getElementById("edit-password").value.trim(),
      name: document.getElementById("edit-name").value.trim(),
      birth: document.getElementById("edit-birth").value || null,
      region: document.getElementById("edit-region").value.trim(),
      profileUrl: document.getElementById("edit-profileUrl").value.trim(),
    };

    if (!updateData.userId || !updateData.name) {
      alert("아이디와 이름은 필수 입력 항목입니다.");
      return;
    }

    await fetch("/api/me", {
      method: "PATCH",
      headers: { "Content-Type": "application/json" },
      credentials: "include",
      body: JSON.stringify(updateData),
    });

    alert("프로필이 수정되었습니다!");
    document.getElementById("edit-form").classList.add("hidden");
    await loadProfile();
  }

  // === 계정 삭제 ===
  if (e.target.id === "delete-btn") {
    if (!confirm("정말 계정을 삭제하시겠습니까?")) return;

    try {
      // 1️⃣ 계정 삭제
      await fetch("/api/me", { method: "DELETE", credentials: "include" });

      // 2️⃣ 로그아웃 요청
      await fetch("/api/auth/logout", { method: "POST", credentials: "include" });

      // 3️⃣ localStorage 정리
      localStorage.removeItem("isLoggedIn");
      localStorage.removeItem("username");

      // 4️⃣ 홈으로 이동
      alert("계정이 삭제되고 로그아웃되었습니다.");
      window.location.href = "index.html";
    } catch (err) {
      console.error("❌ 계정 삭제 중 오류:", err);
      alert("계정 삭제 중 오류가 발생했습니다.");
    }
  }
});

window.addEventListener("DOMContentLoaded", loadLayout);
