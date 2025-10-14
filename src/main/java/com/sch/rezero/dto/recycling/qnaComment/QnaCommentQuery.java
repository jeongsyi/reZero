package com.sch.rezero.dto.recycling.qnaComment;

public record QnaCommentQuery(
        Long idAfter,
        String cursor,
        Integer size,
        String sortField,
        String sortDirection
) {
    public QnaCommentQuery {
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
