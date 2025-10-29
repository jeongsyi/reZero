package com.sch.rezero.dto.community.communityPost;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;

public record CommunityPostCreateRequest(
    @Size(max = 255)
    @NotBlank
    String title,

    @NotBlank
    String description
) {
}
