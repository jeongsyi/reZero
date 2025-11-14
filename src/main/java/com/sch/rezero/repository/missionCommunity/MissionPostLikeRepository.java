package com.sch.rezero.repository.missionCommunity;

import com.sch.rezero.entity.community.Like;
import com.sch.rezero.entity.community.MissionPostLike;
import com.sch.rezero.entity.user.User;
import java.util.Optional;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface MissionPostLikeRepository extends JpaRepository<MissionPostLike, Long>, MissionPostLikeQueryRepository {
  Optional<MissionPostLike> findByMissionPostIdAndUserId(Long postId, Long userId);
  Boolean existsByMissionPostIdAndUserId(Long postId, Long userId);

  Long user(User user);
}
