package com.sch.rezero.dto.community.communityPost;

import java.time.LocalDateTime;
import java.util.List;

public record CommunityPostResponse(
    Long id,
    Long userId,
    String userName,
    String title,
    String description,

    Integer likeCount,
    Integer commentCount,
    List<String> imageUrls,

    LocalDateTime createdAt,
    LocalDateTime updatedAt
) {

}
