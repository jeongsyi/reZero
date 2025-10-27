package com.sch.rezero.entity.recycling;

import com.sch.rezero.entity.user.User;
import jakarta.persistence.*;
import lombok.AccessLevel;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

@Entity
@Getter
@Table(name = "recycling_posts")
@NoArgsConstructor(access = AccessLevel.PROTECTED)
@AllArgsConstructor
public class RecyclingPost {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "user_id", nullable = false)
    private User user;

    @Column(nullable = false)
    private String title;

    @Column(columnDefinition = "TEXT", nullable = false)
    private String description;

    @Column(name = "thumb_nail_image", nullable = false)
    private String thumbNailImageUrl;

    @ManyToOne(optional = false, fetch = FetchType.LAZY)
    @JoinColumn(name = "category_id", nullable = false)
    private Category category;

    @CreationTimestamp
    @Column(name = "created_at", updatable = false, nullable = false)
    private LocalDateTime createdAt;

    @UpdateTimestamp
    @Column(name = "updated_at")
    private LocalDateTime updatedAt;

    @OneToMany(mappedBy = "post", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<QnaComment> comments = new ArrayList<>();

    @OneToMany(mappedBy = "post", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<RecyclingImage> images = new ArrayList<>();

    @OneToMany(mappedBy = "post", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<Scrap> scraps = new ArrayList<>();

    public RecyclingPost(User user, String title, String description, String thumbNailImageUrl, Category category) {
        this.user = user;
        this.title = title;
        this.description = description;
        this.thumbNailImageUrl = thumbNailImageUrl;
        this.category = category;
    }

    public void update(String title, String description, String thumbNailImage, Category category) {
        if (!this.title.equals(title) && title != null) {
            this.title = title;
        }
        if (!this.description.equals(description) && description != null) {
            this.description = description;
        }
        if (!this.thumbNailImageUrl.equals(thumbNailImage) && thumbNailImage != null) {
            this.thumbNailImageUrl = thumbNailImage;
        }

        if (category != null) {
            this.category = category;
        }
    }

    public void addImage(RecyclingImage image) {
        this.images.add(image);
    }

    public void deleteImage(RecyclingImage image) {
       this.images.remove(image);
    }
}
