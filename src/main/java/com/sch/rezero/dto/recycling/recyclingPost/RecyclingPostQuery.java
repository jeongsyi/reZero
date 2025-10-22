package com.sch.rezero.dto.recycling.recyclingPost;

public record RecyclingPostQuery(
        String title,
        String description,
        String userName,
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
            sortField = "createdAt";
        }
        if (sortDirection == null) {
            sortDirection = "desc";
        }
    }

    //UserId로 검색할 때만 사용함
    public RecyclingPostQuery updateUserName(String userName) {
        return new RecyclingPostQuery(
                null,
                null,
                userName,
                idAfter,
                cursor,
                size,
                sortField,
                sortDirection);
    }
}
