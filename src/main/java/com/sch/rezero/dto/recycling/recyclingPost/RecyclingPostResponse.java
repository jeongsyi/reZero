package com.sch.rezero.dto.recycling.recyclingPost;

import java.time.LocalDateTime;
import java.util.List;

public record RecyclingPostResponse(
        Long id,
        String title,
        String description,
        String thumbNailImageUrl,
        String category,
        LocalDateTime createdAt,
        LocalDateTime updatedAt,
        String userName,

        List<String> imageUrls,
        Integer commentCount,
        Integer scrapCount
) {
}