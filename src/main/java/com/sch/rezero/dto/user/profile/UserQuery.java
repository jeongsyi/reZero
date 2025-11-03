package com.sch.rezero.dto.user.profile;

public record UserQuery(
        String name,
        String id,
        Long idAfter,
        String cursor,
        Integer size,
        String sortField,
        String sortDirection
) {
    public UserQuery {
        if (size == null) {
            size = 20;
        }
        if (sortField == null) {
            sortField = "name";
        }
        if (sortDirection == null) {
            sortDirection = "asc";
        }
    }
}
