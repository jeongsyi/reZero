package com.sch.rezero.dto.user.profile;

import java.time.LocalDate;

public record ProfileResponse(
        Long id,
        String userId,
        String name,
        String role,
        String region,
        LocalDate birth,
        String profileUrl,

        Integer followerCount,
        Integer followingCount
) {

}
