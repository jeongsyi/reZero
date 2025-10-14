package com.sch.rezero.dto.community.communityComment;

public record CommunityCommentQuery(
        Long postId,
        Long idAfter,
        String cursor,
        Integer size,
        String sortField,
        String sortDirection
) {
    public CommunityCommentQuery {
        if (size == null) {
            size = 20;
        }
        if (sortField == null) {
            sortField = "createdAt";
        }
        if (sortDirection == null) {
            sortDirection = "asc";
        }
    }
}
