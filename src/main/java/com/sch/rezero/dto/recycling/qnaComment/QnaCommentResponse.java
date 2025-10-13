package com.sch.rezero.dto.recycling.qnaComment;

import java.time.LocalDateTime;
import java.util.List;


public record QnaCommentResponse(
        Long id,
        Long parentId,
        String content,
        LocalDateTime createdAt,
        LocalDateTime updatedAt,
        String userName,
        List<QnaCommentResponse> children
) {
}
