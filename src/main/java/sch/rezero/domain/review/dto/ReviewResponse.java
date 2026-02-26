package sch.rezero.domain.review.dto;

import java.time.LocalDateTime;

public record ReviewResponse(
    Long id,
    Long storeId,
    Long userId,
    String content,
    LocalDateTime createdAt
) {

}
