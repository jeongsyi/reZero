package com.sch.rezero.dto.user.follow;

public record FollowQuery(
        String name,
        Long idAfter,
        String cursor,
        Integer size,
        String sortField,
        String sortDirection
) {
    public FollowQuery {
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
