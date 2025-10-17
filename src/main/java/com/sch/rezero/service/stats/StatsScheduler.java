package com.sch.rezero.service.stats;

import lombok.RequiredArgsConstructor;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import java.util.Map;

@Component
@RequiredArgsConstructor
public class StatsScheduler {
    private final StatsService statsService;

    private Map<String, Double> cachedRegionStats;
    private Map<String, Double> cachedAgeStats;

    @Scheduled(cron = "0 */30 * * * *")
    public void updateStats() {
        cachedRegionStats = statsService.getRegionCount();
        cachedAgeStats = statsService.getAgeGroupCount();
    }

    public Map<String, Double> getRegionStats() {
        return cachedRegionStats;
    }

    public Map<String, Double> getAgeGroupStats() {
        return cachedAgeStats;
    }
}