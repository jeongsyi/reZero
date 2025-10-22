async function loadLayout() {
    const headerHtml = await fetch("header.html").then(res => res.text());
    document.getElementById("header-placeholder").innerHTML = headerHtml;

    const footerHtml = await fetch("footer.html").then(res => res.text());
    document.getElementById("footer-placeholder").innerHTML = footerHtml;

    // 💡 header가 로드된 뒤에 실행돼야 함
    applyLoginState();
}

function applyLoginState() {
    const isLoggedIn = localStorage.getItem("isLoggedIn") === "true";
    const authLink = document.getElementById("authLink");

    if (authLink) {
        if (isLoggedIn) {
            authLink.innerHTML = `
        <a href="#" onclick="logout()" style="color:#ffffff;font-weight:600;">로그아웃</a>
      `;
        } else {
            authLink.innerHTML = `
        <a href="login.html" style="color:#ffffff;font-weight:600;">로그인 / 회원가입</a>
      `;
        }
    }
}

function logout() {
    fetch("/api/auth/logout", { method: "POST" });
    localStorage.removeItem("isLoggedIn");
    localStorage.removeItem("username");
    window.location.href = "index.html";
}

window.addEventListener("DOMContentLoaded", loadLayout);
