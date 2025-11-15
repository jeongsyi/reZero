package com.sch.rezero.service.missionCommunity;

import com.sch.rezero.dto.missionCommunity.ranking.MissionRankingResponse;
import jakarta.annotation.PostConstruct;
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

  @PostConstruct
  @Transactional(readOnly = true)
  public void initRankingOnStartup() {
    cachedRankings = missionRankingService.calculateRankings();
  }

  @Scheduled(cron = "0 0 1 * * *")
  @Transactional(readOnly = true)
  public void updateRankings() {
    cachedRankings = missionRankingService.calculateRankings();
  }

  public List<MissionRankingResponse> getCachedRankings() {
    return cachedRankings;
  }
}
