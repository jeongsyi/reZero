package com.sch.rezero.dto.missionCommunity.stamp;

import java.time.LocalDate;
import java.util.List;

public record MissionStampWeeklyResponse(
    Long missionId,
    String missionTitle,
    LocalDate startDate,
    LocalDate endDate,
    List<MissionStampResponse> stamps
) {
  public MissionStampWeeklyResponse {
    if (stamps == null) {
      stamps = List.of(); // NPE 방지
    }
  }
}
