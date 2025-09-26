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

    private LocalDate birth;
    private String region;

    @OneToMany(mappedBy = "user", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<CommunityPost> communityPosts = new ArrayList<>();

    @OneToMany(mappedBy = "user", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<CommunityComment> comments = new ArrayList<>();

}
