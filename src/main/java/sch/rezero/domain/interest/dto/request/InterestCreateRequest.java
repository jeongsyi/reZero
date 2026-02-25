package sch.rezero.domain.interest.dto.request;

import jakarta.validation.constraints.NotBlank;

public record InterestCreateRequest(
    @NotBlank
    Long categoryId,

    @NotBlank
    Long userId
) {

}