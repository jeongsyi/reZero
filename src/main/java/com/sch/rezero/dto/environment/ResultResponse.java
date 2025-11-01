package com.sch.rezero.dto.environment;

import java.time.LocalDateTime;

public record ResultResponse(
    Long userId,
    int totalScore,
    String levelName,
    String description
) {

}
