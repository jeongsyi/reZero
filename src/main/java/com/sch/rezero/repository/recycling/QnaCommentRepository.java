package com.sch.rezero.repository.recycling;

import com.sch.rezero.entity.recycling.QnaComment;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface QnaCommentRepository extends JpaRepository<QnaComment, Long> {
    List<QnaComment> findAllByPostId(Long postId);
}
