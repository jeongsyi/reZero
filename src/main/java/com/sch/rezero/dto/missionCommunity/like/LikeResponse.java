package com.sch.rezero.dto.missionCommunity.like;

import java.time.LocalDateTime;

public record LikeResponse(
    Long postId,
    Long userId,
    LocalDateTime createdAt
) {

}
