package com.sch.rezero.entity.community;

import com.sch.rezero.entity.user.User;
import jakarta.persistence.CascadeType;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;
import jakarta.persistence.FetchType;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.OneToMany;
import jakarta.persistence.OneToOne;
import jakarta.persistence.Table;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import lombok.AccessLevel;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Entity
@Getter
@Table(name = "mission_posts")
@NoArgsConstructor(access = AccessLevel.PROTECTED)
@AllArgsConstructor
public class MissionPost {

  @Id
  @GeneratedValue(strategy = GenerationType.IDENTITY)
  private Long id;

  @Column(nullable = false)
  private String title;

  @Column(columnDefinition = "TEXT")
  private String description;

  @Enumerated(EnumType.STRING)
  @Column(nullable = false)
  private Status status = Status.PENDING;;

  @Column(name = "created_at", nullable = false, updatable = false)
  private LocalDateTime createdAt = LocalDateTime.now();

  @Column(name = "updated_at")
  private LocalDateTime updatedAt;

  @ManyToOne(fetch = FetchType.LAZY)
  @JoinColumn(name = "user_id", nullable = false)
  private User user;

  @ManyToOne(fetch = FetchType.LAZY)
  @JoinColumn(name = "mission_id", nullable = false)
  private Mission mission;

  @OneToMany(mappedBy = "missionPost", cascade = CascadeType.ALL, orphanRemoval = true)
  private List<MissionPostComment> comments = new ArrayList<>();

  @OneToMany(mappedBy = "missionPost", cascade = CascadeType.ALL, orphanRemoval = true)
  private List<MissionPostImage> images = new ArrayList<>();

  @OneToMany(mappedBy = "missionPost", cascade = CascadeType.ALL, orphanRemoval = true)
  private List<MissionPostLike> likes = new ArrayList<>();

  public enum Status {
    PENDING, APPROVED, REJECTED
  }

  public void update(String title, String description) {
    if (title != null && !title.equals(this.title)) {
      this.title = title;
    }
    if (description != null && !description.equals(this.description)) {
      this.description = description;
    }
    this.updatedAt = LocalDateTime.now();
  }

  public void approve() {
    this.status = Status.APPROVED;
    this.updatedAt = LocalDateTime.now();
  }

  public void reject() {
    this.status = Status.REJECTED;
    this.updatedAt = LocalDateTime.now();
  }

  public void pending() {
    this.status = Status.PENDING;
    this.updatedAt = LocalDateTime.now();
  }

  public void addImage(MissionPostImage image) {
    this.images.add(image);
  }

  public void deleteImage(MissionPostImage image) {
    this.images.remove(image);
  }

  public MissionPost(String title, String description, Mission mission, User user) {
    this.title = title;
    this.description = description;
    this.mission = mission;
    this.user = user;
  }
}
