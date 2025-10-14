package com.sch.rezero.dto.community.communityComment;

import java.time.LocalDateTime;
import java.util.List;

public record CommunityCommentResponse(
        Long id,
        Long parentId,
        String userName,
        String content,
        LocalDateTime createdAt,
        LocalDateTime updatedAt,
        List<CommunityCommentResponse> children
) {
    public CommunityCommentResponse {
        if (children == null) {
            children = List.of();
        }
    }
}