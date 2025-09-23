package com.sch.rezero.dto.recyclingPost;

import java.time.LocalDateTime;
import java.util.List;

public record RecyclingPostResponse(
        Long id,
        String title,
        String description,
        String thumbNailImage,
        String category,
        LocalDateTime createdAt,
        LocalDateTime updatedAt,
        String userName,

        List<Long> imageIds,
        Integer commentCount,
        Integer scrapCount
) {
}