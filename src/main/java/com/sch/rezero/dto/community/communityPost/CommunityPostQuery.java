package com.sch.rezero.dto.community.communityPost;

public record CommunityPostQuery(
        String title,
        String description,
        String userName,
        Long idAfter,
        String cursor,
        Integer size,
        String sortField,
        String sortDirection
) {
    public CommunityPostQuery {
        if (size == null) {
            size = 20;
        }
        if (sortField == null) {
            sortField = "createdAt";
        }
        if (sortDirection == null) {
            sortDirection = "desc";
        }
    }
}
