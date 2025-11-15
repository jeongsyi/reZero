package com.sch.rezero.entity.notification;

import com.sch.rezero.entity.user.User;
import jakarta.persistence.*;
import java.time.LocalDateTime;
import lombok.*;

@Entity
@Getter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
@AllArgsConstructor
@Builder
@Table(name = "notifications")
public class Notification {

  @Id
  @GeneratedValue(strategy = GenerationType.IDENTITY)
  private Long id;

  @ManyToOne(fetch = FetchType.LAZY)
  @JoinColumn(name = "user_id", nullable = false)
  private User user; // 알림 받는 사람

  @ManyToOne(fetch = FetchType.LAZY)
  @JoinColumn(name = "sender_id")
  private User sender; // 알림 보낸 사람

  @Column(name = "post_id")
  private Long postId;

  @Column(nullable = false, length = 20)
  @Enumerated(EnumType.STRING)
  private Type type;

  @Column(nullable = false, columnDefinition = "TEXT")
  private String message;

  @Column(nullable = false)
  private boolean isRead = false;

  @Column(nullable = false, name = "created_at")
  private LocalDateTime createdAt = LocalDateTime.now();

  public enum Type {
    LIKE, COMMENT, APPROVED, REJECTED, MESSAGE
  }

  public void markAsRead() {
    this.isRead = true;
  }
}
