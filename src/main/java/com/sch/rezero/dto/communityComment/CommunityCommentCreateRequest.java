package com.sch.rezero.dto.communityComment;

import jakarta.validation.constraints.NotBlank;

public record CommunityCommentCreateRequest(
    Long parentId,

    @NotBlank
    String content
) {

}
