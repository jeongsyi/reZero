package com.sch.rezero.dto.qnaComment;

import jakarta.validation.constraints.NotBlank;

public record QnaCommentUpdateRequest(
        @NotBlnak
        String content
) {
}
