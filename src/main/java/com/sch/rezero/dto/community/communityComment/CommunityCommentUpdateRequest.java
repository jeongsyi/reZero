package com.sch.rezero.dto.community.communityComment;

import jakarta.validation.constraints.NotBlank;

public record CommunityCommentUpdateRequest(
    @NotBlank
    String content
) {

}
