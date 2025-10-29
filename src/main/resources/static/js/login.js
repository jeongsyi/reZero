async function handleLogin() {
    const loginId = document.getElementById("loginId").value.trim();
    const password = document.getElementById("password").value.trim();
    const errorMsg = document.getElementById("errorMsg");
    errorMsg.textContent = "";

    if (!loginId || !password) {
        errorMsg.textContent = "아이디와 비밀번호를 모두 입력해주세요.";
        return;
    }

    try {
        const response = await fetch("/api/auth/login", {
            method: "POST",
            headers: { "Content-Type": "application/json" },
            body: JSON.stringify({ loginId, password }),
        });

        if (!response.ok) {
            throw new Error("로그인 실패");
        }

        const data = await response.json();

        // 로그인 성공 → localStorage에 로그인 상태 저장
        localStorage.setItem("isLoggedIn", "true");
        localStorage.setItem("userId", data.userId);
        localStorage.setItem("username", data.name);
        localStorage.setItem("role", data.role);

        // alert 제거 — 바로 메인 페이지로 이동
        window.location.href = "index.html";
    } catch (error) {
        errorMsg.textContent = "아이디 또는 비밀번호가 올바르지 않습니다.";
    }
}