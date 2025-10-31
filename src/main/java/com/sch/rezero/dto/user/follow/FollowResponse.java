package com.sch.rezero.dto.user.follow;

import java.time.LocalDateTime;

public record FollowResponse(
    Long followingId,
    LocalDateTime createdAt,
    Boolean subscribedByMe
) {

}
