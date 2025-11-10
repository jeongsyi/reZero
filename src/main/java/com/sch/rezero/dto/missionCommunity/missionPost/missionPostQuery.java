package com.sch.rezero.dto.missionCommunity.missionPost;

public record missionPostQuery(
        String title,
        String description,
        String userName,
        Long idAfter,
        String cursor,
        Integer size,
        String sortField,
        String sortDirection
) {
    public missionPostQuery {
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
