package sch.rezero.domain.group.dto;

import java.time.LocalDateTime;

public record GroupResponse(
    Long id,
    Long leaderId,
    String name,
    String description,
    LocalDateTime createdAt
) {

}
