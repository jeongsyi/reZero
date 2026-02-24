package sch.rezero.domain.scrap.dto.response;

import java.time.LocalDateTime;

public record ScrapResponse (
	Long postId,
	Long userId,
	LocalDateTime createdAt
) {}