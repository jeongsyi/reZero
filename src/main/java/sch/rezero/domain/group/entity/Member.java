package sch.rezero.domain.group.entity;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import jakarta.persistence.UniqueConstraint;
import java.time.LocalDateTime;
import lombok.Getter;

@Entity
@Getter
@Table(
    name = "group_members",
    uniqueConstraints = {
        @UniqueConstraint(name = "uk_group_member", columnNames = {"group_id", "user_id"})
    }
)
public class Member {

  @Id
  @GeneratedValue(strategy = GenerationType.IDENTITY)
  private Long id;

  @Column(name = "user_id", nullable = false)
  private Long userId;

  @Column(name = "group_id", nullable = false)
  private Long groupId;

  @Column(name = "approved", nullable = false)
  private Boolean approved;

  @Column(name = "joined_at", nullable = false)
  private LocalDateTime joinedAt;

}
