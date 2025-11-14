package com.sch.rezero.dto.missionCommunity.missionPost;

public record MissionPostQuery(
        String title,
        String description,
        String userName,
        String status,
        Long idAfter,
        String cursor,
        Integer size,
        String sortField,
        String sortDirection
) {
    public MissionPostQuery {
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

    public MissionPostQuery withStatus(String newStatus) {
        return new MissionPostQuery(
            title,
            description,
            userName,
            newStatus,
            idAfter,
            cursor,
            size,
            sortField,
            sortDirection
        );
    }
}
