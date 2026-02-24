package sch.rezero.domain.comment.dto.response;

import java.time.LocalDateTime;

public record CommentResponse(
	Long id,
	Long parentId,
	String content,
	LocalDateTime createdAt,
	LocalDateTime updatedAt,
	String userName
){}