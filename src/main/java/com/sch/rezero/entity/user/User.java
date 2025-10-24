package com.sch.rezero.entity.user;

import com.sch.rezero.entity.community.CommunityComment;
import com.sch.rezero.entity.community.CommunityPost;
import com.sch.rezero.entity.community.Like;
import com.sch.rezero.entity.recycling.RecyclingPost;
import com.sch.rezero.entity.recycling.Scrap;
import jakarta.persistence.*;
import java.util.ArrayList;
import java.util.List;
import lombok.AccessLevel;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;

import java.time.LocalDate;

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
        if (loginId != null && !this.loginId.equals(loginId)) {
            this.loginId = loginId;
        }
        if (password != null && !this.password.equals(password)) {
            this.password = password;
        }
        if (name != null && !this.name.equals(name)) {
            this.name = name;
        }
        if (profileUrl != null || (this.profileUrl != null && profileUrl == null)) {
            this.profileUrl = profileUrl;
        }

        if (birth != null || (this.birth != null && birth == null)) {
            this.birth = birth;
        }

        if (region != null || (this.region != null && region == null)) {
            this.region = region;
        }
    }
}
