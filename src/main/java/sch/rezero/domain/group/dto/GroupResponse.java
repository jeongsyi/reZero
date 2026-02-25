package sch.rezero.domain.group.dto;

import java.time.LocalDateTime;

public record GroupResponse(
    Long leaderId,
    String name,
    String description,
    LocalDateTime createdAt
) {

}
