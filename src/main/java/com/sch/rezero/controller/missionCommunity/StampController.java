package com.sch.rezero.controller.missionCommunity;

import com.sch.rezero.config.UserContext;
import com.sch.rezero.dto.missionCommunity.stamp.MissionStampResponse;
import com.sch.rezero.entity.community.MissionStamp;
import com.sch.rezero.repository.missionCommunity.MissionStampRepository;
import com.sch.rezero.service.missionCommunity.MissionStampQueryService;
import java.time.DayOfWeek;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequiredArgsConstructor
public class StampController {
  private final UserContext userContext;
  private final MissionStampQueryService missionStampQueryService;

  @GetMapping("/api/mission/stamps/week")
  public ResponseEntity<List<MissionStampResponse>> getWeeklyStamps() {
    Long userId = userContext.getCurrentUserId();
    List<MissionStampResponse> result = missionStampQueryService.getWeekStamps(userId);
    return ResponseEntity.ok(result);
  }


}
