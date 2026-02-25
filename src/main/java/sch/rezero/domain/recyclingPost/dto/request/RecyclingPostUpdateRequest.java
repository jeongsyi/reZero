package sch.rezero.domain.recyclingPost.dto.request;

import jakarta.validation.constraints.Size;

public record RecyclingPostUpdateRequest (
	@Size(max = 255)
	String title,
	String description,
	
	@Size(max = 255)
	String thumbNailImage,
	
	Long categoryId
){}