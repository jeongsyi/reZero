package com.sch.rezero.repository.missionCommunity;

import com.sch.rezero.entity.community.MissionPost;
import java.util.List;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

@Repository
public interface MissionPostRepository extends JpaRepository<MissionPost, Long>, MissionPostQueryRepository {
  @Query("SELECT p FROM MissionPost p WHERE p.user.id = :userId ORDER BY p.createdAt DESC")
  List<MissionPost> findByUserId(@Param("userId") Long userId);
}
