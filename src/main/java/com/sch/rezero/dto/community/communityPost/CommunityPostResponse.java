package com.sch.rezero.dto.community.communityPost;

import java.time.LocalDateTime;
import java.util.List;

public record CommunityPostResponse(
    Long id,
    String userName,
    String title,
    String description,

    Integer likeCount,
    Integer commentCount,
    String thumbNailImage,
    List<String> imageUrls,

    LocalDateTime createdAt,
    LocalDateTime updatedAt
) {

}
