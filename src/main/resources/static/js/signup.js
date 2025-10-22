async function handleSignup() {
    const userId = document.getElementById("userId").value.trim();
    const password = document.getElementById("password").value.trim();
    const name = document.getElementById("name").value.trim();
    const birth = document.getElementById("birth").value; // 선택 입력
    const region = document.getElementById("region").value; // 선택 입력
    const errorMsg = document.getElementById("errorMsg");

    errorMsg.textContent = "";

    // 필수 입력만 검사
    if (!userId || !password || !name) {
        errorMsg.textContent = "아이디, 비밀번호, 이름은 필수 입력입니다.";
        return;
    }

    // 비밀번호 유효성 검사
    const pwPattern = /^(?=.*[0-9])(?=.*[a-zA-Z])(?=.*[!@#$%^&*]).{8,}$/;
    if (!pwPattern.test(password)) {
        errorMsg.textContent = "비밀번호는 숫자, 문자, 특수문자를 포함해 8자 이상이어야 합니다.";
        return;
    }

    const payload = {
        userId,
        password,
        name,
        role: "USER",
        birth: birth || null,
        region: region || null,
        profileUrl: null
    };

    try {
        const response = await fetch("/api/auth/signup", {
            method: "POST",
            headers: { "Content-Type": "application/json" },
            body: JSON.stringify(payload),
        });

        if (!response.ok) {
            const errText = await response.text();
            console.error("회원가입 실패:", errText);
            throw new Error("회원가입 실패");
        }

        // 회원가입 성공 시 로그인 페이지로 바로 이동 (팝업 없이)
        window.location.href = "login.html";

    } catch (error) {
        console.error(error);
        errorMsg.textContent = "회원가입 중 오류가 발생했습니다. 다시 시도해주세요.";
    }
}
