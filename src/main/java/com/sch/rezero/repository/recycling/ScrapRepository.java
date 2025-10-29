package com.sch.rezero.repository.recycling;

import com.sch.rezero.entity.recycling.RecyclingPost;
import com.sch.rezero.entity.recycling.Scrap;
import com.sch.rezero.entity.user.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface ScrapRepository extends JpaRepository<Scrap, Long>, ScrapQueryRepository {
    boolean existsByPostIdAndUserId(Long postId, Long userId);
    Optional<Scrap> findByUserAndPost(User user, RecyclingPost post);
}
