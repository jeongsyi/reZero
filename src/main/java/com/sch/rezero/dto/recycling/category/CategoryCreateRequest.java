package com.sch.rezero.dto.recycling.category;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;

public record CategoryCreateRequest(
        @NotBlank
        @Size(max = 20)
        String category
) {
}
