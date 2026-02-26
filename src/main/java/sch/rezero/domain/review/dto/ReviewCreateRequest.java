package sch.rezero.domain.review.dto;

public record ReviewCreateRequest(
    Long storeId,
    String content
) {

}
