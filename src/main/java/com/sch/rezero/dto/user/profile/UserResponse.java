package com.sch.rezero.dto.user.profile;

public record UserResponse(
        Long id,
        String userId,
        String name,
        String role,
        String profileUrl,

        Integer followerCount,
        Integer followingCount
) {

}
