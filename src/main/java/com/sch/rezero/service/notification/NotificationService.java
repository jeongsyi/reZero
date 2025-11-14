package com.sch.rezero.service.notification;

import static org.springframework.transaction.annotation.Propagation.REQUIRES_NEW;

import com.sch.rezero.dto.notification.NotificationMessage;
import com.sch.rezero.dto.notification.NotificationResponse;
import com.sch.rezero.entity.notification.Notification;
import com.sch.rezero.entity.user.User;
import com.sch.rezero.repository.notification.NotificationRepository;
import com.sch.rezero.repository.user.UserRepository;
import java.util.List;
import java.util.stream.Collectors;
import lombok.RequiredArgsConstructor;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@RequiredArgsConstructor
public class NotificationService {

  private final NotificationRepository notificationRepository;
  private final UserRepository userRepository;
  private final SimpMessagingTemplate messagingTemplate;

  @Transactional(propagation = REQUIRES_NEW)
  public void sendNotification(Long receiverId, Long senderId, Notification.Type type, String message, Long postId) {
    User receiver = userRepository.findById(receiverId)
        .orElseThrow(() -> new IllegalArgumentException("수신자 없음"));
    User sender = senderId != null ? userRepository.findById(senderId).orElse(null) : null;

    Notification notification = Notification.builder()
        .user(receiver)
        .sender(sender)
        .postId(postId)
        .type(type)
        .message(message)
        .build();

    notificationRepository.save(notification);

    // WebSocket 실시간 전송
    messagingTemplate.convertAndSendToUser(
        receiverId.toString(),
        "/queue/notifications",
        new NotificationMessage(
            type.name(),
            message,
            postId,
            senderId,
            sender != null ? sender.getName() : "시스템"
        )
    );
  }

  @Transactional(readOnly = true)
  public List<NotificationResponse> getUserNotifications(Long userId) {
    User user = userRepository.findById(userId)
        .orElseThrow(() -> new IllegalArgumentException("유저 없음"));
    return notificationRepository.findByUserOrderByCreatedAtDesc(user).stream()
        .map(n -> NotificationResponse.builder()
            .id(n.getId())
            .type(n.getType().name())
            .message(n.getMessage())
            .isRead(n.isRead())
            .postId(n.getPostId())
            .senderName(n.getSender() != null ? n.getSender().getName() : "시스템")
            .createdAt(n.getCreatedAt())
            .build())
        .collect(Collectors.toList());
  }

  @Transactional
  public void markAsRead(Long userId, Long notificationId) {
    Notification n = notificationRepository.findById(notificationId)
        .orElseThrow(() -> new IllegalArgumentException("알림 없음"));
    if (!n.getUser().getId().equals(userId)) {
      throw new IllegalStateException("본인 알림만 읽을 수 있습니다.");
    }
    n.markAsRead();
  }

  @Transactional
  public void markAllAsRead(Long userId) {
    User user = userRepository.findById(userId)
        .orElseThrow(() -> new IllegalArgumentException("유저 없음"));
    List<Notification> list = notificationRepository.findByUserOrderByCreatedAtDesc(user);
    list.forEach(Notification::markAsRead);
  }
}

