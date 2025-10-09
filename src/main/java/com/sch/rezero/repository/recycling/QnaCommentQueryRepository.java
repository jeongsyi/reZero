package com.sch.rezero.repository.recycling;

import com.sch.rezero.dto.recycling.qnaComment.QnaCommentQuery;
import com.sch.rezero.dto.response.CursorPageResponse;
import com.sch.rezero.entity.recycling.QnaComment;

import java.util.List;

public interface QnaCommentQueryRepository {
    CursorPageResponse<QnaComment> findAll(QnaCommentQuery qnaCommentQuery);
    List<QnaComment> findRepliesByParentIds(List<Long> parentIds);
}
