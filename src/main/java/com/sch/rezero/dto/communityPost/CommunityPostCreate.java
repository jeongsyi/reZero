package com.sch.rezero.dto.communityPost;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;
import java.util.List;

public record CommunityPostCreate(
    @Size(max = 255)
    @NotBlank
    String title,

    @NotBlank
    String description,

    @Size(max = 255)
    @NotBlank
    String thumbNailImage,

    List<@NotNull Long> imageIds
) {
}
