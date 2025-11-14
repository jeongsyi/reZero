package com.sch.rezero.controller.missionCommunity;

import com.sch.rezero.dto.missionCommunity.ranking.MissionRankingResponse;
import com.sch.rezero.service.missionCommunity.MissionRankingBatch;
import java.util.List;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RequiredArgsConstructor
@RestController
@RequestMapping("/api/missions/rankings")
public class MissionRankingController {

  private final MissionRankingBatch missionRankingBatch;

  @GetMapping
  public ResponseEntity<List<MissionRankingResponse>> getRankings() {
    return ResponseEntity.ok(missionRankingBatch.getCachedRankings());
  }

}
