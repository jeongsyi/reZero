package sch.rezero.domain.scrap.dto.request;

import jakarta.validation.constraints.NotBlank;

public record ScrapCreateRequest (
  @NotBlank
  Long postId,

  @NotBlank
  Long userId
){}