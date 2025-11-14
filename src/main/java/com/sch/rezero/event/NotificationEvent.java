package com.sch.rezero.event;

import com.sch.rezero.entity.notification.Notification;
import lombok.Getter;
import org.springframework.context.ApplicationEvent;

@Getter
public class NotificationEvent extends ApplicationEvent {
  private final Long receiverId;   // 알림 받을 사람
  private final Long senderId;     // 알림 보낸 사람
  private final Notification.Type type;
  private final String message;
  private final Long postId;

  public NotificationEvent(Object source, Long receiverId, Long senderId, Notification.Type type, String message, Long postId) {
    super(source);
    this.receiverId = receiverId;
    this.senderId = senderId;
    this.type = type;
    this.message = message;
    this.postId = postId;
  }
}
