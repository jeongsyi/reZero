package com.sch.rezero.dto.community.communityComment;

import java.time.LocalDateTime;
import java.util.List;

public record CommunityCommentResponse(
        Long id,
        Long parentId,
        Long userId,
        String userName,
        String content,
        LocalDateTime createdAt,
        LocalDateTime updatedAt,
        List<CommunityCommentResponse> children,
        String profileUrl
) {
    public CommunityCommentResponse {
        if (children == null) {
            children = List.of();
        }
    }
}