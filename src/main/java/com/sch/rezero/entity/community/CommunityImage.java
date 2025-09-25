package com.sch.rezero.entity.community;

import jakarta.persistence.Column;
import jakarta.persistence.FetchType;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import java.time.LocalDateTime;

public class CommunityImage {

  @Id
  @GeneratedValue(strategy = GenerationType.IDENTITY)
  Long id;

  @ManyToOne(fetch = FetchType.LAZY)
  @JoinColumn(name = "community_id")
  CommunityPost communityPost;

  @Column(nullable = false)
  String image_url;

  @Column(name = "created_at", nullable = false)
  private LocalDateTime createdAt;

  @Column(name = "updated_at")
  private LocalDateTime updatedAt;

  private void update(String image_url) {
    if (image_url != null && !image_url.equals(this.image_url)) {
      this.image_url = image_url;
    }

    this.updatedAt = LocalDateTime.now();
  }

}
