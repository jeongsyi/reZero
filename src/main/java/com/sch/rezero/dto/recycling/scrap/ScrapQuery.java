package com.sch.rezero.dto.recycling.scrap;

public record ScrapQuery(
        Long userId,
        Long idAfter,
        String cursor,
        Integer size,
        String sortField,
        String sortDirection
) {
    public ScrapQuery {
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
