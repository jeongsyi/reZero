//--------------------------------------------------
// 1) 레이아웃 로드
//--------------------------------------------------

async function loadLayout() {
  const headerHtml = await fetch("header.html").then(res => res.text());
  document.getElementById("header-placeholder").innerHTML = headerHtml;

  const footerHtml = await fetch("footer.html").then(res => res.text());
  document.getElementById("footer-placeholder").innerHTML = footerHtml;

  applyLoginState();        // 로그인 상태 반영
  setupNotificationUI();    // 알림 아이콘 추가
  connectWebSocket();       // WebSocket 연결
  loadNotifications();      // 기존 알림 로드
}

window.addEventListener("DOMContentLoaded", loadLayout);


//--------------------------------------------------
// 2) 로그인 UI 처리
//--------------------------------------------------

function applyLoginState() {
  const isLoggedIn = localStorage.getItem("isLoggedIn") === "true";
  const authLink = document.getElementById("authLink");

  if (!authLink) return;

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

function logout() {
  fetch("/api/auth/logout", { method: "POST", credentials: "include" });
  localStorage.removeItem("isLoggedIn");
  localStorage.removeItem("username");
  localStorage.removeItem("userId");
  window.location.href = "index.html";
}


//--------------------------------------------------
// 3) 알림 UI 생성
//--------------------------------------------------

function setupNotificationUI() {
  const isLoggedIn = localStorage.getItem("isLoggedIn") === "true";
  const navMenu = document.getElementById("navMenu");

  if (!isLoggedIn || !navMenu) return;

  // 이미 존재하면 중복 생성 방지
  if (document.getElementById("notifyArea")) return;

  const notifyHTML = `
      <li id="notifyArea" style="position:relative; margin-left: 6px;">
          <div id="notifyBtn" style="cursor:pointer; position:relative; font-size:20px;">
              🔔
              <span id="notifyBadge"
                    style="
                      display:none;
                      position:absolute; top:-5px; right:-10px;
                      background:red; color:white;
                      border-radius:10px; padding:2px 6px;
                      font-size:10px;">
              0</span>
          </div>

          <div id="notifyDropdown"
               style="
                 display:none;
                 position:absolute; right:-60px; top:30px;
                 background:#fff; width:250px;
                 border-radius:10px; padding:10px;
                 box-shadow:0 4px 10px rgba(0,0,0,0.15);
                 z-index:999;">
              <div id="notifyList"></div>
          </div>
      </li>
  `;

  navMenu.insertAdjacentHTML("beforeend", notifyHTML);

  // 드롭다운 열기만 (읽음 처리 X)
  document.getElementById("notifyBtn").onclick = () => {
    const drop = document.getElementById("notifyDropdown");
    drop.style.display = drop.style.display === "none" ? "block" : "none";
  };
}


//--------------------------------------------------
// 4) WebSocket 연결
//--------------------------------------------------

let stompClient = null;

function connectWebSocket() {
  if (localStorage.getItem("isLoggedIn") !== "true") return;

  const userId = localStorage.getItem("userId");
  if (!userId) return;

  const socket = new SockJS('/ws');
  stompClient = Stomp.over(socket);

  stompClient.connect({}, () => {
    stompClient.subscribe(`/user/queue/notifications`, (msg) => {
      const n = JSON.parse(msg.body);
      addNotification(n);
      increaseBadge();
    });
  });
}


//--------------------------------------------------
// 5) 기존 알림 불러오기
//--------------------------------------------------

function loadNotifications() {
  if (localStorage.getItem("isLoggedIn") !== "true") return;

  fetch("/api/notifications", { credentials: "include" })
  .then(res => res.json())
  .then(list => {
    renderNotificationList(list);
    updateBadgeFromUnread(list);
  });
}



//--------------------------------------------------
// 6) 알림 목록 렌더링 (읽지 않은 것만)
//--------------------------------------------------

function renderNotificationList(list) {
  const wrap = document.getElementById("notifyList");
  if (!wrap) return;

  wrap.innerHTML = "";

  list
  .filter(n => !n.isRead)   // ⭐ FIXED: isRead 기준
  .slice(0, 5)
  .forEach(n => {
    wrap.insertAdjacentHTML("beforeend", notificationHTML(n));
  });

  addNotificationClickEvents();
}


// 알림 HTML 템플릿
function notificationHTML(n) {
  return `
    <div class="dropdown-item"
         data-id="${n.id}"
         data-postid="${n.postId}"
         style="
           cursor:pointer; padding:8px 5px;
           border-bottom:1px solid #eee;">
        <div><strong>${n.type}</strong> ${n.message}</div>
        <span style="width:6px;height:6px;background:green;border-radius:50%;
                     display:inline-block;margin-top:5px;"></span>
    </div>
  `;
}



//--------------------------------------------------
// 7) 실시간 알림 추가
//--------------------------------------------------

function addNotification(n) {
  const wrap = document.getElementById("notifyList");
  if (!wrap) return;

  wrap.insertAdjacentHTML("afterbegin", notificationHTML(n));
  addNotificationClickEvents();
}



//--------------------------------------------------
// 8) 알림 클릭 → 읽음 처리 + UI 제거 + 이동
//--------------------------------------------------

function addNotificationClickEvents() {
  const items = document.querySelectorAll(".dropdown-item");

  items.forEach(item => {
    item.onclick = async () => {
      const id = item.dataset.id;
      const postId = item.dataset.postid;

      // 개별 읽음 처리 API
      await fetch(`/api/notifications/${id}/read`, {
        method: "PATCH",
        credentials: "include"
      });

      // UI에서 제거
      item.remove();

      // 배지 감소
      decreaseBadge();

      // 게시글로 이동
      window.location.href = `community-detail.html?id=${postId}`;
    };
  });
}



//--------------------------------------------------
// 9) 배지 증가/감소 처리
//--------------------------------------------------

function increaseBadge() {
  const badge = document.getElementById("notifyBadge");
  if (!badge) return;

  let count = Number(badge.innerText || 0) + 1;
  badge.innerText = count;
  badge.style.display = "inline-block";
}

function decreaseBadge() {
  const badge = document.getElementById("notifyBadge");
  if (!badge) return;

  let count = Number(badge.innerText || 0) - 1;
  count = Math.max(0, count);

  if (count === 0) badge.style.display = "none";
  else badge.innerText = count;
}

function updateBadgeFromUnread(list) {
  const badge = document.getElementById("notifyBadge");
  if (!badge) return;

  const unread = list.filter(n => !n.isRead).length; // ⭐ FIXED

  if (unread > 0) {
    badge.innerText = unread;
    badge.style.display = "inline-block";
  } else {
    badge.style.display = "none";
  }
}
