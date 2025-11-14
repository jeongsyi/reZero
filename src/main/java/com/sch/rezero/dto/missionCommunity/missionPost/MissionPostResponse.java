package com.sch.rezero.dto.missionCommunity.missionPost;

import java.time.LocalDateTime;
import java.util.List;

public record MissionPostResponse(
    Long id,
    Long userId,
    String title,
    String description,
    String status,
    String authorName,
    int likeCount,
    int commentCount,
    List<String> imageUrls,
    LocalDateTime createdAt
) {

}
