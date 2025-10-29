package com.sch.rezero.repository.community;

import com.sch.rezero.entity.community.CommunityPost;
import com.sch.rezero.entity.community.Like;
import com.sch.rezero.entity.user.User;
import java.util.Optional;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface LikeRepository extends JpaRepository<Like, Long>, LikeQueryRepository {
    boolean existsByUserAndCommunityPost(User user, CommunityPost communityPost);
    Optional<Like> findByUserAndCommunityPost(User user, CommunityPost communityPost);
}
