package com.sch.rezero.dto.recycling.recyclingPost;

import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;

import java.util.List;

public record RecyclingPostUpdateRequest(
        @Size(max = 255)
        String title,
        String description,

        @Size(max = 255)
        String thumbNailImage,

        List<@NotNull Long> imageIds,

        @Size(max = 20)
        String category
) {
}
