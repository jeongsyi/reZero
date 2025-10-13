package com.sch.rezero.repository.recycling;

import com.sch.rezero.entity.recycling.QnaComment;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface QnaCommentRepository extends JpaRepository<QnaComment, Long>, QnaCommentQueryRepository {
}
