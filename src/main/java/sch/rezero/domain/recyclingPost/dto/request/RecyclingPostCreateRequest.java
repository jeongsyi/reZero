package sch.rezero.domain.recyclingPost.dto.request;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;

public record RecyclingPostCreateRequest(
    @Size(max = 255)
    @NotBlank
    String title,

    @NotBlank
    String description,

    @Size(max = 255)
    @NotBlank
    String thumbNailImage,

    @NotNull
    Long categoryId
) {

}