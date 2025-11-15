/* ===============================
   chat-list.js — 채팅방 목록 로딩
   =============================== */

document.addEventListener("DOMContentLoaded", () => {
  loadChatList();
});


async function loadChatList() {
  const res = await fetch("/api/chat/my-rooms"); // 🔥 새로운 API 필요
  const list = await res.json();

  const container = document.getElementById("chatListContainer");
  container.innerHTML = "";

  list.forEach(room => {
    const item = document.createElement("div");
    item.className = "chat-list-item";
    item.dataset.roomId = room.roomId;
    item.dataset.partnerId = room.partnerId;

    item.innerHTML = `
      <img src="${room.partnerProfileImageUrl || "/images/default-profile.png"}">
      <div class="chat-list-info">
        <div class="chat-list-name">${room.partnerNickname}</div>
        <div class="chat-list-last">${room.lastMessage ?? ""}</div>
      </div>
    `;

    // 클릭 시 해당 방으로 이동
    item.onclick = () => {
      window.location.href = `/chat.html?user=${room.partnerId}`;
    };

    container.appendChild(item);
  });
}
