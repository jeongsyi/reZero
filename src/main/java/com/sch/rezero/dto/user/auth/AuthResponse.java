package com.sch.rezero.dto.user.auth;

public record AuthResponse(
    String userId,
    String name,
    String role,
    String profileUrl
) {

}
