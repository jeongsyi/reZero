package com.sch.rezero.service.missionCommunity;

import com.sch.rezero.dto.missionCommunity.ranking.MissionRankingResponse;
import java.util.ArrayList;
import java.util.List;
import lombok.RequiredArgsConstructor;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@RequiredArgsConstructor
public class MissionRankingBatch {
  private final MissionRankingService missionRankingService;

  private List<MissionRankingResponse> cachedRankings = new ArrayList<>();

  /** 매일 새벽 1시 실행 */
  @Scheduled(cron = "0 25 0 * * *")
  @Transactional(readOnly = true)
  public void updateRankings() {
    cachedRankings = missionRankingService.calculateRankings();
    System.out.println("미션 랭킹 계산 완료 (Top5 캐시 업데이트)");
  }

  public List<MissionRankingResponse> getCachedRankings() {
    return cachedRankings;
  }

}
