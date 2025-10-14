package com.sch.rezero.repository.community;

import com.sch.rezero.entity.community.CommunityComment;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface CommunityCommentRepository extends JpaRepository<CommunityComment, Long>, CommunityCommentQueryRepository {
}
