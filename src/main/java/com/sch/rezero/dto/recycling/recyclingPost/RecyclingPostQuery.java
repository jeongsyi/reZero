package com.sch.rezero.dto.recycling.recyclingPost;

public record RecyclingPostQuery(
        String title,
        String description,
        Long idAfter,
        String cursor,
        Integer size,
        String sortField,
        String sortDirection
) {
    public RecyclingPostQuery {
        if (size == null) {
            size = 20;
        }
        if (sortField == null) {
            sortField = "id";
        }
        if (sortDirection == null) {
            sortDirection = "desc";
        }
    }
}
