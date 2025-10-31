package com.sch.rezero.dto.user.follow;

import java.time.LocalDateTime;

public record FollowDto(
        Long userId,
        String name,
        String profileUrl,
        LocalDateTime createdAt
) {

}