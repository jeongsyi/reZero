package com.sch.rezero.dto.recycling.qnaComment;

import jakarta.validation.constraints.NotBlank;

public record QnaCommentUpdateRequest(
        @NotBlank
        String content
) {
}
