package com.sch.rezero.dto.missionCommunity.missionComment;

import java.time.LocalDateTime;
import java.util.List;

public record MissionCommentResponse(
    Long id,
    Long parentId,
    Long userId,
    String userName,
    String content,
    LocalDateTime createdAt,
    LocalDateTime updatedAt,
    List<MissionCommentResponse> children,
    String profileUrl
) {
  public MissionCommentResponse {
    if (children == null) {
      children = List.of();
    }
  }
}
