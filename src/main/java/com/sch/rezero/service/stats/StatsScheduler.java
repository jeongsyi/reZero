package com.sch.rezero.service.stats;

import jakarta.annotation.PostConstruct;
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

    @PostConstruct
    public void initStats() {
        updateStats();
    }

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