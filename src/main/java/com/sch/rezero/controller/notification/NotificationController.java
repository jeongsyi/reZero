package com.sch.rezero.controller.notification;

import com.sch.rezero.config.UserContext;
import com.sch.rezero.dto.notification.NotificationResponse;
import com.sch.rezero.service.notification.NotificationService;
import java.util.List;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequiredArgsConstructor
@RequestMapping("/api/notifications")
public class NotificationController {

  private final NotificationService notificationService;
  private final UserContext userContext;

  @GetMapping
  public ResponseEntity<List<NotificationResponse>> getMyNotifications() {
    Long userId = userContext.getCurrentUserId();
    return ResponseEntity.ok(notificationService.getUserNotifications(userId));
  }

  @PatchMapping("/{notificationId}/read")
  public ResponseEntity<Void> markAsRead(@PathVariable Long notificationId) {
    Long userId = userContext.getCurrentUserId();
    notificationService.markAsRead(userId, notificationId);
    return ResponseEntity.noContent().build();
  }

  @PatchMapping("/read-all")
  public ResponseEntity<Void> markAllAsRead() {
    Long userId = userContext.getCurrentUserId();
    notificationService.markAllAsRead(userId);
    return ResponseEntity.noContent().build();
  }
}
