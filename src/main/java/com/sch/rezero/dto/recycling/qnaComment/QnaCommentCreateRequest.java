package com.sch.rezero.dto.recycling.qnaComment;

import jakarta.validation.constraints.NotBlank;

public record QnaCommentCreateRequest(
        Long parentId,

        @NotBlank
        String content
) {
}
