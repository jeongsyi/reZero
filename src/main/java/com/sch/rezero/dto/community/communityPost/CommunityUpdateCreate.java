package com.sch.rezero.dto.community.communityPost;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;
import java.util.List;

public record CommunityUpdateCreate(
    @Size(max = 255)
    String title,
    String description,

    @Size(max = 255)
    String thumbNailImage
) {
}
