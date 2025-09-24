package com.sch.rezero.dto.community.communityComment;

import jakarta.validation.constraints.NotBlank;

public record CommunityCommentCreateRequest(
    Long parentId,

    @NotBlank
    String content
) {

}
