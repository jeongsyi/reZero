package com.sch.rezero.dto.community.like;

import java.time.LocalDateTime;

public record LikeResponse(
    Long postId,
    Long userId,
    LocalDateTime createdAt
) {

}