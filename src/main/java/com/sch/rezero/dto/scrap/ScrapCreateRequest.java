package com.sch.rezero.dto.scrap;

import jakarta.validation.constraints.NotBlank;

public record ScrapCreateRequest(
        @NotBlank
        Long postId,

        @NotBlank
        Long userId
) {
}
