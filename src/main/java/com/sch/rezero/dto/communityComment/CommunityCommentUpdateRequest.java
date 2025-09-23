package com.sch.rezero.dto.communityComment;

import jakarta.validation.constraints.NotBlank;

public record CommunityCommentUpdateRequest(
    @NotBlank
    String content
) {

}
