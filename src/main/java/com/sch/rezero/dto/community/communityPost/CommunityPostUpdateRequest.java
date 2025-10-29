package com.sch.rezero.dto.community.communityPost;

import jakarta.validation.constraints.Size;

public record CommunityPostUpdateRequest(
    @Size(max = 255)
    String title,
    String description
) {
}
