package sch.rezero.domain.group.dto;

import java.time.LocalDateTime;

public record GroupUpdateRequest(
    Long leaderId,
    String name,
    String description
) {

}
