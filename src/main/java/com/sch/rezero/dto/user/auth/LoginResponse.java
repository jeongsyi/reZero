package com.sch.rezero.dto.user.auth;

public record LoginResponse(
    String userId,
    String name,
    String role,
    String profileUrl
) {

}
