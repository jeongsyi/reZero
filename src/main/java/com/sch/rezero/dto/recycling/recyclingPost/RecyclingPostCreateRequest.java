package com.sch.rezero.dto.recycling.recyclingPost;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;

import java.util.List;

public record RecyclingPostCreateRequest(
        @Size(max = 255)
        @NotBlank
        String title,

        @NotBlank
        String description,

        @Size(max = 255)
        @NotBlank
        String thumbNailImage,

        List<@NotBlank String> imageUrls,

        @Size(max = 20)
        @NotBlank
        String category
) {
}