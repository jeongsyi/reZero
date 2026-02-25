package sch.rezero.domain.group.dto;

import java.time.LocalDateTime;

public record GroupCreateRequest(
    String name,
    String description,
    LocalDateTime createdAt
) {

}
