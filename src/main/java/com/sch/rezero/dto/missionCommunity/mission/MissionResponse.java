package com.sch.rezero.dto.missionCommunity.mission;

import java.time.LocalDateTime;

public record MissionResponse(
    Long id,
    String title,
    String description,
    LocalDateTime startDate,
    LocalDateTime endDate,
    boolean active,
    LocalDateTime createdAt,
    LocalDateTime updatedAt
) {

}
