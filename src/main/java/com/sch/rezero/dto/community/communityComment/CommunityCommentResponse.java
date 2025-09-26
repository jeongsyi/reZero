package com.sch.rezero.dto.community.communityComment;

import java.time.LocalDateTime;

public record CommunityCommentResponse(
    Long id,
    String userName,
    String content,
    LocalDateTime createdAt,
    LocalDateTime updatedAt
) {

}
