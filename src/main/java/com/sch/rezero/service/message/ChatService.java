package com.sch.rezero.service.message;

import com.sch.rezero.dto.message.ChatMessageDto;
import com.sch.rezero.dto.message.ChatRoomDto;
import com.sch.rezero.entity.message.ChatMessage;
import com.sch.rezero.entity.message.ChatRoom;
import com.sch.rezero.entity.notification.Notification;
import com.sch.rezero.entity.notification.Notification.Type;
import com.sch.rezero.entity.user.User;
import com.sch.rezero.event.NotificationEvent;
import com.sch.rezero.repository.message.ChatMessageRepository;
import com.sch.rezero.repository.message.ChatRoomRepository;
import com.sch.rezero.repository.user.UserRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.context.ApplicationEventPublisher;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.List;

@Service
@RequiredArgsConstructor
@Transactional(readOnly = true)
public class ChatService {

  private final ChatRoomRepository roomRepo;
  private final ChatMessageRepository msgRepo;
  private final UserRepository userRepo;
  private final ApplicationEventPublisher eventPublisher;
  private final SimpMessagingTemplate messaging;

  /* ===================================================
        1) 채팅방 생성 / 조회
     =================================================== */
  @Transactional
  public ChatRoomDto.RoomInfo getOrCreateRoom(Long meId, Long partnerId) {

    User me = getUser(meId);
    User partner = getUser(partnerId);

    ChatRoom room = roomRepo.findExisting(me, partner)
        .orElseGet(() -> roomRepo.save(
            ChatRoom.builder()
                .user1(me)
                .user2(partner)
                .createdAt(LocalDateTime.now())
                .build()
        ));

    return ChatRoomDto.RoomInfo.builder()
        .roomId(room.getId())
        .partnerId(partner.getId())
        .partnerNickname(partner.getName())
        .partnerProfileImageUrl(partner.getProfileUrl())
        .build();
  }

  /* ===================================================
        2) 메시지 전송 + WebSocket 알림
     =================================================== */
  @Transactional
  public ChatMessageDto.Response sendMessage(Long meId, ChatMessageDto.Request req) {

    User me = getUser(meId);
    ChatRoom room = roomRepo.findById(req.getRoomId())
        .orElseThrow(() -> new IllegalArgumentException("채팅방 없음"));

    if (!room.isParticipant(me))
      throw new IllegalArgumentException("이 채팅방 참가자가 아님");

    ChatMessage saved = msgRepo.save(ChatMessage.builder()
        .chatRoom(room)
        .sender(me)
        .content(req.getContent())
        .isRead(false)
        .createdAt(LocalDateTime.now())
        .build()
    );

    ChatMessageDto.Response dto = convertToResponse(saved);

    // 상대방 ID
    Long partnerId = room.getUser1().getId().equals(meId)
        ? room.getUser2().getId()
        : room.getUser1().getId();

    // 🔥 실시간 메시지 전달
    messaging.convertAndSendToUser(
        partnerId.toString(),
        "/queue/chat",
        dto
    );

    // 🔔 알림 이벤트 (상단 알림)
    eventPublisher.publishEvent(
        new NotificationEvent(
            this,
            partnerId,
            meId,
            Type.MESSAGE,
            me.getName() + "님이 메시지를 보냈습니다.",
            null
        )
    );

    return dto;
  }

  /* ===================================================
        3) 메시지 조회
     =================================================== */
  public List<ChatMessageDto.Response> getMessages(
      Long meId, Long roomId, Long cursor, int size
  ) {
    User me = getUser(meId);
    ChatRoom room = roomRepo.findById(roomId)
        .orElseThrow(() -> new IllegalArgumentException("채팅방 없음"));

    if (!room.isParticipant(me))
      throw new IllegalArgumentException("이 채팅방 참가자가 아님");

    List<ChatMessage> messages =
        cursor == null
            ? msgRepo.findTop50ByChatRoomOrderByIdDesc(room)
            : msgRepo.findTop50ByChatRoomAndIdLessThanOrderByIdDesc(room, cursor);

    if (messages.size() > size)
      messages = messages.subList(0, size);

    messages.sort((a, b) -> a.getId().compareTo(b.getId()));

    return messages.stream().map(this::convertToResponse).toList();
  }

  /* ===================================================
        4) 읽음 처리 + WebSocket 브로드캐스트
     =================================================== */
  @Transactional
  public void markMessagesAsRead(Long roomId, Long readerId) {

    ChatRoom room = roomRepo.findById(roomId)
        .orElseThrow(() -> new IllegalArgumentException("채팅방 없음"));

    User reader = getUser(readerId);

    List<ChatMessage> unread = msgRepo.findByChatRoomAndSenderIdNotAndIsReadFalse(
        room, readerId
    );

    unread.forEach(ChatMessage::markAsRead);

    // 💥 상대방에게 "읽음됨" 실시간 알려주기
    Long partnerId = room.getUser1().getId().equals(readerId)
        ? room.getUser2().getId()
        : room.getUser1().getId();

    messaging.convertAndSendToUser(
        partnerId.toString(),
        "/queue/read",
        roomId   // 방 번호만 보내면 프론트가 알아서 처리함
    );
  }

  /* ===================================================
        내부 유틸
     =================================================== */
  private User getUser(Long id) {
    return userRepo.findById(id)
        .orElseThrow(() -> new IllegalArgumentException("유저 없음"));
  }

  private ChatMessageDto.Response convertToResponse(ChatMessage m) {
    return ChatMessageDto.Response.builder()
        .id(m.getId())
        .roomId(m.getChatRoom().getId())
        .senderId(m.getSender().getId())
        .senderNickname(m.getSender().getName())
        .content(m.getContent())
        .isRead(m.getIsRead())
        .readAt(m.getReadAt())
        .createdAt(m.getCreatedAt())
        .build();
  }
}
