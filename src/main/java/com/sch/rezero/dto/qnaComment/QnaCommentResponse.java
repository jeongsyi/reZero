package com.sch.rezero.dto.qnaComment;

import java.time.LocalDateTime;

public record QnaCommentResponse(
        Long id,
        Long parentId,
        String content,
        LocalDateTime createdAt,
        LocalDateTime updatedAt,
        String userName
) {
}
