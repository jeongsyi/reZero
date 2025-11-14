package com.sch.rezero.dto.missionCommunity.missionComment;

public record MissionCommentQuery(
        Long idAfter,
        String cursor,
        Integer size,
        String sortField,
        String sortDirection
) {
    public MissionCommentQuery {
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
