package com.sch.rezero.entity.community;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import java.time.LocalDateTime;
import lombok.AccessLevel;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Entity
@Getter
@Table(name = "missions")
@NoArgsConstructor(access = AccessLevel.PROTECTED)
@AllArgsConstructor
public class Mission {

  @Id
  @GeneratedValue(strategy = GenerationType.IDENTITY)
  private Long id;

  @Column(nullable = false, length = 255)
  private String title;

  @Column(nullable = false, length = 255)
  private String description;

  @Column(name = "start_date", nullable = false)
  private LocalDateTime startDate;

  @Column(name = "end_date", nullable = false)
  private LocalDateTime endDate;

  @Column(nullable = false)
  private boolean active;

  @Column(name = "created_at", nullable = false)
  private LocalDateTime createdAt = LocalDateTime.now();

  @Column(name = "updated_at")
  private LocalDateTime updatedAt;

  public void update(String title, String description, LocalDateTime startDate, LocalDateTime endDate) {
    if (title != null && !title.equals(this.title)) {
      this.title = title;
    }
    if (description != null && !description.equals(this.description)) {
      this.description = description;
    }
    if (startDate != null && !startDate.equals(this.startDate)) {
      this.startDate = startDate;
    }
    if (endDate != null && !endDate.equals(this.endDate)) {
      this.endDate = endDate;
    }
    this.updatedAt = LocalDateTime.now();
  }

  public Mission(String title, String description, LocalDateTime startDate, LocalDateTime endDate,
      boolean active) {
    this.title = title;
    this.description = description;
    this.startDate = startDate;
    this.endDate = endDate;
    this.active = active;
    this.createdAt = LocalDateTime.now();
  }
}
