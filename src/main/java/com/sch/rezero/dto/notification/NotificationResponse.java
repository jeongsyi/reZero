package com.sch.rezero.dto.notification;

import java.time.LocalDateTime;
import lombok.Builder;

@Builder
public record NotificationResponse(
    Long id,
    String type,
    String message,
    boolean isRead,
    Long postId,
    String senderName,
    LocalDateTime createdAt
) { }

