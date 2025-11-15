/* ===========================
   chat.js — DM 채팅 + 실시간 읽음 UI
   =========================== */

let roomId = null;
let partnerId = null;
let nextCursor = null;
let loading = false;
let meId = null;

let stomp = null;

/* -------------------------------------
   페이지 로드되면 실행
-------------------------------------- */
document.addEventListener("DOMContentLoaded", async () => {

  await loadHeaderFooter();
  await connectWebSocket();

  const params = new URLSearchParams(window.location.search);
  partnerId = params.get("user");

  // 로그인 정보
  const meRes = await fetch("/api/me");
  const me = await meRes.json();
  meId = me.id;

  // 채팅방
  await loadChatRoom();

  // 메시지 로딩
  await loadMessages(false);

  document.getElementById("sendBtn").onclick = sendMessage;
  document.getElementById("messageInput").addEventListener("keydown", e => {
    if (e.key === "Enter") sendMessage();
  });

  const chatBox = document.getElementById("chatMessages");
  chatBox.addEventListener("scroll", async () => {
    if (chatBox.scrollTop === 0 && !loading && nextCursor) {
      await loadMessages(true);
    }
  });
});


/* ---------------------------
   WebSocket 연결 + 구독
--------------------------- */
async function connectWebSocket() {
  const socket = new SockJS("/ws");
  stomp = Stomp.over(socket);
  stomp.debug = null;

  stomp.connect({}, () => {

    // 💬 실시간 메시지 도착
    stomp.subscribe(`/user/queue/chat`, (frame) => {
      const msg = JSON.parse(frame.body);
      renderMessage(msg);
      scrollBottom();
    });

    // 📗 실시간 읽음 수신
    stomp.subscribe(`/user/queue/read`, (frame) => {
      const readRoomId = Number(frame.body);
      if (readRoomId === roomId) {
        showReadMarkUI();
      }
    });

  });
}


/* ---------------------------
   header/footer include
--------------------------- */
async function loadHeaderFooter() {
  const header = await fetch("/header.html").then(r => r.text());
  document.getElementById("header-placeholder").innerHTML = header;

  const footer = await fetch("/footer.html").then(r => r.text());
  document.getElementById("footer-placeholder").innerHTML = footer;
}


/* ---------------------------
   방 생성/조회
--------------------------- */
async function loadChatRoom() {
  const res = await fetch(`/api/chat/room?partnerId=${partnerId}`);
  const data = await res.json();

  roomId = data.roomId;
  document.getElementById("partnerName").textContent = data.partnerNickname;
  document.getElementById("partnerImg").src =
      data.partnerProfileImageUrl || "/images/default-profile.png";
}


/* ---------------------------
   메시지 로딩
--------------------------- */
async function loadMessages(loadOld = false) {
  loading = true;

  let url = `/api/chat/messages?roomId=${roomId}&size=30`;
  if (loadOld && nextCursor) url += `&cursor=${nextCursor}`;

  const res = await fetch(url);
  const list = await res.json();

  const chatBox = document.getElementById("chatMessages");
  const prevHeight = chatBox.scrollHeight;

  list.forEach(msg => renderMessage(msg, loadOld));

  nextCursor = list.length > 0 ? list[0].id : null;

  if (!loadOld) scrollBottom();
  else chatBox.scrollTop = chatBox.scrollHeight - prevHeight;

  loading = false;

  if (!loadOld) markMessagesAsRead();
}


/* ---------------------------
   메시지 렌더링
--------------------------- */
function renderMessage(msg, prepend = false) {
  const chatBox = document.getElementById("chatMessages");

  const wrapper = document.createElement("div");
  wrapper.className = msg.senderId === meId ? "msg my-msg" : "msg other-msg";
  wrapper.dataset.msgId = msg.id;

  wrapper.innerHTML = `
    <div class="msg-content">${msg.content}</div>
    <div class="msg-time">${formatTime(msg.createdAt)}</div>
    ${msg.senderId === meId && msg.isRead ? `<div class="read-mark">읽음</div>` : ""}
  `;

  if (prepend) chatBox.prepend(wrapper);
  else chatBox.appendChild(wrapper);
}


/* ---------------------------
   메시지 전송
--------------------------- */
async function sendMessage() {
  const input = document.getElementById("messageInput");
  const content = input.value.trim();
  if (!content) return;

  const res = await fetch("/api/chat/send", {
    method: "POST",
    headers: { "Content-Type": "application/json" },
    body: JSON.stringify({ roomId, content })
  });

  const msg = await res.json();
  renderMessage(msg);
  scrollBottom();

  input.value = "";
}


/* ---------------------------
   읽음 처리 API
--------------------------- */
async function markMessagesAsRead() {
  await fetch(`/api/chat/${roomId}/read`, { method: "PATCH" });
}


/* ---------------------------
   읽음된 UI 표기
--------------------------- */
function showReadMarkUI() {
  // 내 메시지들 중 "읽음표시 없는" 모든 것에 표시 추가
  document.querySelectorAll(".my-msg").forEach(div => {
    if (!div.querySelector(".read-mark")) {
      const readDiv = document.createElement("div");
      readDiv.className = "read-mark";
      readDiv.textContent = "읽음";
      div.appendChild(readDiv);
    }
  });
}


/* ---------------------------
   Util
--------------------------- */
function formatTime(ts) {
  return new Date(ts).toLocaleTimeString("ko-KR", {
    hour: "2-digit",
    minute: "2-digit"
  });
}

function scrollBottom() {
  const chatBox = document.getElementById("chatMessages");
  chatBox.scrollTop = chatBox.scrollHeight;
}
