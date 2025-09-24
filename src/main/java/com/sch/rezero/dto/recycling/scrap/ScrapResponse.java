package com.sch.rezero.dto.recycling.scrap;

import java.time.LocalDateTime;

public record ScrapResponse(
        Long postId,
        Long userId,
        LocalDateTime createdAt
) {
}
