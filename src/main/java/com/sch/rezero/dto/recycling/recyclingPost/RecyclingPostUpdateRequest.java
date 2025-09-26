package com.sch.rezero.dto.recycling.recyclingPost;

import jakarta.validation.constraints.Size;

public record RecyclingPostUpdateRequest(
        @Size(max = 255)
        String title,
        String description,

        @Size(max = 255)
        String thumbNailImage,

        @Size(max = 20)
        String category
) {
}