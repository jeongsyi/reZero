package com.sch.rezero.entity.user;

import com.sch.rezero.entity.community.CommunityComment;
import com.sch.rezero.entity.community.CommunityPost;
import jakarta.persistence.*;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import lombok.AccessLevel;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Entity
@Getter
@Table(name = "users")
@NoArgsConstructor(access = AccessLevel.PROTECTED)
@AllArgsConstructor
public class User {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "login_id", nullable = false)
    private String loginId;

    @Column(nullable = false)
    private String password;

    @Column(nullable = false)
    private String name;

    @Enumerated(EnumType.STRING)
    @Column(nullable = false)
    private Role role;

    @Column(name = "profile_url")
    private String profileUrl;

    private LocalDate birth;
    private String region;

    // ✅ 팔로워 / 팔로잉 카운트 추가
    @Column(name = "follower_count", nullable = false)
    private Long followerCount = 0L;

    @Column(name = "following_count", nullable = false)
    private Long followingCount = 0L;

    @OneToMany(mappedBy = "user", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<CommunityPost> communityPosts = new ArrayList<>();

    @OneToMany(mappedBy = "user", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<CommunityComment> comments = new ArrayList<>();

    public User(String loginId, String password, String name, Role role,
        String profileUrl, LocalDate birth, String region) {
        this.loginId = loginId;
        this.password = password;
        this.name = name;
        this.role = (role != null) ? role : Role.USER;
        this.profileUrl = profileUrl;
        this.birth = birth;
        this.region = region;
    }

    public void update(String loginId, String password, String name, String profileUrl,
        LocalDate birth, String region) {
        if (loginId != null && !this.loginId.equals(loginId)) this.loginId = loginId;
        if (password != null && !this.password.equals(password)) this.password = password;
        if (name != null && !this.name.equals(name)) this.name = name;
        if (profileUrl != null || (this.profileUrl != null && profileUrl == null)) this.profileUrl = profileUrl;
        if (birth != null || (this.birth != null && birth == null)) this.birth = birth;
        if (region != null || (this.region != null && region == null)) this.region = region;
    }

    // ✅ 팔로워 / 팔로잉 카운트 관련 메서드
    public void increaseFollowerCount() {
        this.followerCount++;
    }

    public void decreaseFollowerCount() {
        if (this.followerCount > 0) this.followerCount--;
    }

    public void increaseFollowingCount() {
        this.followingCount++;
    }

    public void decreaseFollowingCount() {
        if (this.followingCount > 0) this.followingCount--;
    }
}
