package sch.rezero.config.exception;

public record ErrorResponse(
    String code,
    String description,
    Integer httpStatus
) {

}
