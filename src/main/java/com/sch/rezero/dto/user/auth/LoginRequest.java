package com.sch.rezero.dto.user.auth;

import jakarta.validation.constraints.NotBlank;

public record LoginRequest(
    @NotBlank
    String loginId,

    @NotBlank
    String password
) {

}
