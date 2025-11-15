package com.sch.rezero.entity.message;

import static jakarta.persistence.FetchType.LAZY;

import com.sch.rezero.entity.user.User;
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

@Entity
@Table(name = "chat_rooms")
@Getter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class ChatRoom {

  @Id
  @GeneratedValue(strategy = GenerationType.IDENTITY)
  private Long id;

  @ManyToOne(fetch = LAZY)
  @JoinColumn(name = "user1_id")
  private User user1;

  @ManyToOne(fetch = LAZY)
  @JoinColumn(name = "user2_id")
  private User user2;

  private LocalDateTime createdAt;

  public boolean isParticipant(User user) {
    Long uid = user.getId();
    return user1.getId().equals(uid) || user2.getId().equals(uid);
  }
}
