package com.sch.rezero.entity.message;

import static jakarta.persistence.FetchType.LAZY;

import com.sch.rezero.entity.user.User;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
import java.time.LocalDateTime;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.springframework.stereotype.Service;

@Entity
@Table(name = "chat_messages")
@Getter @Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class ChatMessage {

  @Id
  @GeneratedValue(strategy = GenerationType.IDENTITY)
  private Long id;

  @ManyToOne(fetch = LAZY)
  @JoinColumn(name = "room_id")
  private ChatRoom chatRoom;

  @ManyToOne(fetch = LAZY)
  @JoinColumn(name = "sender_id")
  private User sender;

  @Column(columnDefinition = "TEXT")
  private String content;

  @Column(nullable = false)
  private Boolean isRead = false;

  private LocalDateTime readAt;

  private LocalDateTime createdAt;

  public void markAsRead() {
    this.isRead = true;
    this.readAt = LocalDateTime.now();
  }
}
