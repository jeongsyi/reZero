package com.sch.rezero.dto.notification;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class NotificationMessage {
  private String type;       // LIKE, COMMENT, APPROVED, REJECTED
  private String message;
  private Long postId;
  private Long senderId;
  private String senderName;
}
