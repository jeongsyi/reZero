package com.sch.rezero.dto.missionCommunity.missionPost;

import java.time.LocalDateTime;
import java.util.List;

public record MissionPostResponse(
    Long id,
    String title,
    String description,
    String status,
    String authorName,
    Long likeCount,
    Long commentCount,
    List<String> imageUrls,
    LocalDateTime createdAt
) {

}
