package com.sch.rezero.entity.community;

import com.sch.rezero.entity.user.User;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
import jakarta.persistence.UniqueConstraint;
import java.time.LocalDate;
import java.time.LocalDateTime;
import lombok.Getter;

@Entity
@Getter
@Table(
    name = "mission_stamps",
    uniqueConstraints = {@UniqueConstraint(columnNames = {"mission_id", "user_id", "stamp_date"})})
public class MissionStamp {

  @Id
  @GeneratedValue(strategy = GenerationType.IDENTITY)
  private Long id;

  @ManyToOne(fetch = FetchType.LAZY)
  @JoinColumn(name = "mission_id", nullable = false)
  private Mission mission;

  @ManyToOne(fetch = FetchType.LAZY)
  @JoinColumn(name = "user_id", nullable = false)
  private User user;

  @Column(name = "stamp_date", nullable = false)
  private LocalDate stampDate;

  @Column(nullable = false)
  private boolean stamped;

  @Column(name = "stamped_at")
  private LocalDateTime stampedAt;

  public void stamp() {
    this.stamped = true;
    this.stampedAt = LocalDateTime.now();
  }

  public void unstamp() {
    this.stamped = false;
    this.stampedAt = null;
  }


}
