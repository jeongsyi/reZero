// /* ===============================
//    chat.js — DM 채팅 로직 (최종 완성본)
//    =============================== */
//
// let roomId = null;
// let partnerId = null;
// let nextCursor = null;
// let loading = false;
// let meId = null;
//
// /* -------------------------------------
//    페이지 로드되면 실행
// -------------------------------------- */
// document.addEventListener("DOMContentLoaded", async () => {
//   await loadLayout(); // header/footer 공용 로딩
//
//   const params = new URLSearchParams(window.location.search);
//   partnerId = params.get("user");
//
//   if (!partnerId) {
//     alert("잘못된 접근입니다.");
//     return;
//   }
//
//   // 👉 로그인 사용자 정보 확실히 이 값( id )로!
//   const meRes = await fetch("/api/me");
//   const me = await meRes.json();
//   meId = me.id;
//
//   // 🔥 채팅방 가져오기 / 생성
//   await loadChatRoom();
//
//   // 🔥 최신 메시지 로딩
//   await loadMessages(false);
//
//   // 메시지 전송 버튼
//   document.getElementById("sendBtn").onclick = sendMessage;
//
//   // 엔터로 메시지 전송
//   document.getElementById("messageInput").addEventListener("keydown", (e) => {
//     if (e.key === "Enter") sendMessage();
//   });
//
//   // 🔥 스크롤 위 → 이전 메시지 불러오기
//   const chatBox = document.getElementById("chatMessages");
//   chatBox.addEventListener("scroll", async () => {
//     if (chatBox.scrollTop === 0 && !loading && nextCursor) {
//       await loadMessages(true);
//     }
//   });
// });
//
//
// /* ===============================
//    1) 방 생성 or 기존 방 가져오기
//    =============================== */
// async function loadChatRoom() {
//   const res = await fetch(`/api/chat/room?partnerId=${partnerId}`);
//   const data = await res.json();
//   roomId = data.roomId;
//
//   document.getElementById("partnerName").textContent = data.partnerNickname;
//   document.getElementById("partnerImg").src =
//       data.partnerProfileImageUrl || "/images/default-profile.png";
// }
//
//
// /* ===============================
//    2) 메시지 로딩
//    =============================== */
// async function loadMessages(loadOld = false) {
//   loading = true;
//
//   let url = `/api/chat/messages?roomId=${roomId}&size=30`;
//   if (loadOld && nextCursor) {
//     url += `&cursor=${nextCursor}`;
//   }
//
//   const res = await fetch(url);
//   const list = await res.json();
//
//   const chatBox = document.getElementById("chatMessages");
//   let prevScrollHeight = chatBox.scrollHeight;
//
//   // 메시지 렌더링
//   list.forEach(msg => renderMessage(msg, loadOld));
//
//   // 커서 업데이트
//   nextCursor = list.length > 0 ? list[0].id : null;
//
//   if (!loadOld) chatBox.scrollTop = chatBox.scrollHeight;
//   else chatBox.scrollTop = chatBox.scrollHeight - prevScrollHeight;
//
//   loading = false;
//
//   // ⭐ 방 새로 열었을 때만 읽음 처리 실행
//   if (!loadOld) {
//     await markMessagesAsRead(roomId);
//   }
// }
//
//
// /* ===============================
//    3) 메시지 렌더링
//    =============================== */
// function renderMessage(msg, prepend = false) {
//   const chatBox = document.getElementById("chatMessages");
//
//   const wrapper = document.createElement("div");
//   wrapper.className = msg.senderId === meId ? "msg my-msg" : "msg other-msg";
//
//   wrapper.innerHTML = `
//       <div class="msg-content">${msg.content}</div>
//       <div class="msg-time">${formatTime(msg.createdAt)}</div>
//   `;
//
//   if (prepend) chatBox.prepend(wrapper);
//   else chatBox.appendChild(wrapper);
// }
//
//
// /* ===============================
//    4) 메시지 전송
//    =============================== */
// async function sendMessage() {
//   const input = document.getElementById("messageInput");
//   const text = input.value.trim();
//   if (!text) return;
//
//   const res = await fetch("/api/chat/send", {
//     method: "POST",
//     headers: { "Content-Type": "application/json" },
//     body: JSON.stringify({
//       roomId,
//       content: text
//     })
//   });
//
//   const sentMsg = await res.json();
//
//   // 바로 렌더링
//   renderMessage(sentMsg);
//
//   const chatBox = document.getElementById("chatMessages");
//   chatBox.scrollTop = chatBox.scrollHeight;
//
//   input.value = "";
// }
//
//
// /* ===============================
//    5) 읽음 처리 API (정확히 매핑)
//    =============================== */
// async function markMessagesAsRead(roomId) {
//   try {
//     await fetch(`/api/chat/${roomId}/read?userId=${meId}`, {
//       method: "PATCH"
//     });
//
//     console.log("📗 읽음 처리 완료");
//   } catch (e) {
//     console.error("❌ 읽음 처리 실패", e);
//   }
// }
//
//
// /* ===============================
//    Util
//    =============================== */
// function formatTime(dateTime) {
//   return new Date(dateTime).toLocaleTimeString("ko-KR", {
//     hour: "2-digit",
//     minute: "2-digit"
//   });
// }

/* ===========================
   chat.js 전체 코드
   =========================== */

let roomId = null;
let partnerId = null;
let nextCursor = null;
let loading = false;
let meId = null;

document.addEventListener("DOMContentLoaded", async () => {

  await loadHeaderFooter();   // common.js 제거했으므로 직접 include

  const params = new URLSearchParams(window.location.search);
  partnerId = params.get("user");

  const meRes = await fetch("/api/me");
  const me = await meRes.json();
  meId = me.id || me.userId;

  await loadChatRoom();
  await loadMessages(false);

  document.getElementById("sendBtn").onclick = sendMessage;

  document.getElementById("messageInput")
  .addEventListener("keydown", e => {
    if (e.key === "Enter") sendMessage();
  });

  const chatBox = document.getElementById("chatMessages");
  chatBox.addEventListener("scroll", async () => {
    if (chatBox.scrollTop === 0 && !loading && nextCursor) {
      await loadMessages(true);
    }
  });
});

/* -------------------- */
/*  header/footer include */
/* -------------------- */
async function loadHeaderFooter() {
  const header = await fetch("/header.html").then(r => r.text());
  document.getElementById("header-placeholder").innerHTML = header;

  const footer = await fetch("/footer.html").then(r => r.text());
  document.getElementById("footer-placeholder").innerHTML = footer;
}

/* -------------------- */
/*  방 생성/조회 */
/* -------------------- */
async function loadChatRoom() {
  const res = await fetch(`/api/chat/room?partnerId=${partnerId}`);
  const data = await res.json();

  roomId = data.roomId;

  document.getElementById("partnerName").textContent = data.partnerNickname;
  document.getElementById("partnerImg").src =
      data.partnerProfileImageUrl || "/images/default-profile.png";
}

/* -------------------- */
/*  메시지 로딩 */
/* -------------------- */
async function loadMessages(loadOld = false) {
  loading = true;

  let url = `/api/chat/messages?roomId=${roomId}&size=30`;
  if (loadOld && nextCursor) {
    url += `&cursor=${nextCursor}`;
  }

  const res = await fetch(url);
  const list = await res.json();

  const chatBox = document.getElementById("chatMessages");
  const prevHeight = chatBox.scrollHeight;

  list.forEach(msg => renderMessage(msg, loadOld));

  nextCursor = list.length > 0 ? list[0].id : null;

  if (!loadOld)
    chatBox.scrollTop = chatBox.scrollHeight;
  else
    chatBox.scrollTop = chatBox.scrollHeight - prevHeight;

  loading = false;

  // 방을 새로 열었을 때만 읽음 처리
  if (!loadOld) {
    await markMessagesAsRead();
  }
}

/* -------------------- */
/*  메시지 렌더링 */
/* -------------------- */
function renderMessage(msg, prepend = false) {
  const chatBox = document.getElementById("chatMessages");

  const wrapper = document.createElement("div");
  wrapper.className = msg.senderId === meId ? "msg my-msg" : "msg other-msg";

  wrapper.innerHTML = `
      <div class="msg-content">${msg.content}</div>
      <div class="msg-time">${formatTime(msg.createdAt)}</div>
  `;

  if (prepend) chatBox.prepend(wrapper);
  else chatBox.appendChild(wrapper);
}

function formatTime(ts) {
  return new Date(ts).toLocaleTimeString("ko-KR", {
    hour: "2-digit",
    minute: "2-digit"
  });
}

/* -------------------- */
/*  메시지 전송 */
/* -------------------- */
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

  const chatBox = document.getElementById("chatMessages");
  chatBox.scrollTop = chatBox.scrollHeight;

  input.value = "";
}

/* -------------------- */
/*  읽음 처리 */
/* -------------------- */
async function markMessagesAsRead() {
  await fetch(`/api/chat/read?roomId=${roomId}`, {
    method: "PATCH"
  });
}

