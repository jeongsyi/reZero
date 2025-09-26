package com.sch.rezero.entity.community;

import com.sch.rezero.entity.user.User;
import jakarta.persistence.CascadeType;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.Lob;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.OneToMany;
import jakarta.persistence.Table;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import lombok.AccessLevel;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;

@Entity
@Getter
@Table(name = "community_posts")
@NoArgsConstructor(access = AccessLevel.PROTECTED)
@AllArgsConstructor
public class CommunityPost {

  @Id
  @GeneratedValue(strategy = GenerationType.IDENTITY)
  private Long id;

  @ManyToOne(fetch = FetchType.LAZY)
  @JoinColumn(name = "user_id", nullable = false)
  private User user;

  @Column(nullable = false)
  private String title;

  @Lob
  @Column(columnDefinition = "TEXT", nullable = false)
  private String description;

  @CreationTimestamp
  @Column(name = "created_at", nullable = false, updatable = false)
  private LocalDateTime createdAt;

  @UpdateTimestamp
  @Column(name = "updated_at")
  private LocalDateTime updatedAt;

  @OneToMany(mappedBy = "communityPost", cascade = CascadeType.ALL, orphanRemoval = true)
  private List<CommunityComment> comments = new ArrayList<>();

  @OneToMany(mappedBy = "communityPost", cascade = CascadeType.ALL, orphanRemoval = true)
  private List<CommunityImage> images = new ArrayList<>();

  @OneToMany(mappedBy = "communityPost", cascade = CascadeType.ALL, orphanRemoval = true)
  private List<Like> likes = new ArrayList<>();

  public void update(String title, String description) {
    if (title != null && !title.equals(this.title)) {
      this.title = title;
    }
    if (description != null && !description.equals(this.description)) {
      this.description = description;
    }
  }
}
