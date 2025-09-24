package com.sch.rezero.dto.communityComment;

import jakarta.validation.constraints.NotBlank;
import java.time.LocalDateTime;

public record CommunityCommentResponse(
    Long id,
    String userName,
    String content,
    LocalDateTime createdAt,
    LocalDateTime updatedAt
) {

}
