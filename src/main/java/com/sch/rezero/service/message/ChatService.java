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

  /**
   * DM 버튼 클릭 → 방 생성 or 기존 방 반환
   */
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

  /**
   * 메시지 전송 + 💥 실시간 알림 이벤트 발생
   */
  @Transactional
  public ChatMessageDto.Response sendMessage(Long meId, ChatMessageDto.Request req) {

    User me = getUser(meId);
    ChatRoom room = roomRepo.findById(req.getRoomId())
        .orElseThrow(() -> new IllegalArgumentException("채팅방 없음"));

    if (!room.isParticipant(me))
      throw new IllegalArgumentException("이 채팅방 참가자가 아님");

    // 메시지 저장
    ChatMessage message = ChatMessage.builder()
        .chatRoom(room)
        .sender(me)
        .content(req.getContent())
        .isRead(false)
        .createdAt(LocalDateTime.now())
        .build();

    ChatMessage saved = msgRepo.save(message);
    ChatMessageDto.Response dto = convertToResponse(saved);

    // ❤️ 상대방 ID 구하기
    Long partnerId = room.getUser1().getId().equals(meId)
        ? room.getUser2().getId()
        : room.getUser1().getId();

    // 🔔 메시지 알림 이벤트 발행
    eventPublisher.publishEvent(
        new NotificationEvent(
            this,
            partnerId,                // 알림 받을 사람
            meId,                     // 메시지 보낸 사람
            Type.MESSAGE, // 타입… 메시지용 별도 타입 만들고 싶으면 Message로 변경 가능
            me.getName() + "님이 메시지를 보냈습니다.",
            null                      // postId 없음
        )
    );

    return dto;
  }

  /**
   * 이전 메시지 불러오기
   */
  public List<ChatMessageDto.Response> getMessages(
      Long meId, Long roomId, Long cursor, int size
  ) {
    User me = getUser(meId);
    ChatRoom room = roomRepo.findById(roomId)
        .orElseThrow(() -> new IllegalArgumentException("채팅방 없음"));

    if (!room.isParticipant(me))
      throw new IllegalArgumentException("이 채팅방 참가자가 아님");

    // 최신 or cursor 기반 메시지 조회
    List<ChatMessage> messages =
        (cursor == null)
            ? msgRepo.findTop50ByChatRoomOrderByIdDesc(room)
            : msgRepo.findTop50ByChatRoomAndIdLessThanOrderByIdDesc(room, cursor);

    // size 제한
    if (messages.size() > size) {
      messages = messages.subList(0, size);
    }

    // 오름차순 정렬
    messages.sort((a, b) -> a.getId().compareTo(b.getId()));

    // 변환
    return messages.stream()
        .map(this::convertToResponse)
        .toList();
  }

  // ==============================
  // 내부 유틸
  // ==============================

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

  @Transactional
  public void markMessagesAsRead(Long roomId, Long readerId) {

    ChatRoom room = roomRepo.findById(roomId)
        .orElseThrow(() -> new IllegalArgumentException("채팅방 없음"));

    User reader = getUser(readerId);

    List<ChatMessage> unread = msgRepo.findByChatRoomAndSenderIdNotAndIsReadFalse(
        room, readerId
    );

    unread.forEach(ChatMessage::markAsRead);   // setter 활용
  }
}
