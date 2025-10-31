package com.sch.rezero.dto.user.follow;

import java.time.LocalDateTime;

public record FollowDto(
        Long userId,
        String loginId,
        String name,
        String profileUrl,
        LocalDateTime createdAt
) {

}