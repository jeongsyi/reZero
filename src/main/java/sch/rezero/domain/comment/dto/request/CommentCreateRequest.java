package sch.rezero.domain.comment.dto.request;

import jakarta.validation.constraints.NotBlank;

public record CommentCreateRequest(
    Long parentId,

    @NotBlank
    String content
) {
}
