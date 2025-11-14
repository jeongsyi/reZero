package com.sch.rezero.listener;

import com.sch.rezero.event.NotificationEvent;
import com.sch.rezero.service.notification.NotificationService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Component;
import org.springframework.transaction.event.TransactionalEventListener;
import org.springframework.transaction.event.TransactionPhase;

@Slf4j
@Component
@RequiredArgsConstructor
public class NotificationEventListener {
  private final NotificationService notificationService;

  @TransactionalEventListener(phase = TransactionPhase.AFTER_COMMIT)
  public void handleNotificationEvent(NotificationEvent event) {
    try {
      notificationService.sendNotification(
          event.getReceiverId(),
          event.getSenderId(),
          event.getType(),
          event.getMessage(),
          event.getPostId()
      );
      log.info("✅ 알림 전송 완료 → {} (type: {})", event.getReceiverId(), event.getType());
    } catch (Exception e) {
      log.error("❌ 알림 전송 실패", e);
    }
  }
}
