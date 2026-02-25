package sch.rezero.domain.interest.dto.response;

import java.time.LocalDateTime;

public record InterestResponse (
	Long postId,
	Long userId,
	LocalDateTime createdAt
) {}