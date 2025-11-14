package com.sch.rezero.repository.missionCommunity;

import com.sch.rezero.entity.community.MissionPostComment;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface MissionPostCommentRepository extends JpaRepository<MissionPostComment, Long>, MissionPostCommentQueryRepository {

}
