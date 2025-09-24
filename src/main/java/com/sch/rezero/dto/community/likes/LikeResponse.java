package com.sch.rezero.dto.community.likes;

import java.time.LocalDateTime;

public record LikeResponse(
    Long postId,
    Long userId,
    LocalDateTime createdAt
) {

}
