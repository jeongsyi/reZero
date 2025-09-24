package com.sch.rezero.dto.user.profile;

public record UserResponse(
    String userId,
    String name,
    String role,
    String profileUrl,

    Integer follwerCount,
    Integer follwingCount
) {

}
