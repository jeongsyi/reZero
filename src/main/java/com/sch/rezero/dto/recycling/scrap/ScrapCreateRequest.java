package com.sch.rezero.dto.recycling.scrap;

import jakarta.validation.constraints.NotBlank;

public record ScrapCreateRequest(
        @NotBlank
        Long postId,

        @NotBlank
        Long userId
) {
}
