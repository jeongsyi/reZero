package sch.rezero.domain.notification.dto.response;

import java.time.LocalDateTime;

public record NotificationResponse(
    Long id,
    Long userId,
    String title,
    String content,
    boolean isRead,
    LocalDateTime createdAt,
    String targetType,
    Long targetId
) {

}
