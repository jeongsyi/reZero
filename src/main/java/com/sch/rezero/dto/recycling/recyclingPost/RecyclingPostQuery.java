package com.sch.rezero.dto.recycling.recyclingPost;

public record RecyclingPostQuery(
        String title,
        String description,
        Long idAfter,
        String cursor,
        int size,
        String sortField,
        String sortDirection
) {
}
