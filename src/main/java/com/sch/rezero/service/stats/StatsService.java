package com.sch.rezero.service.stats;

import com.sch.rezero.dto.stats.AgeGroupCountDto;
import com.sch.rezero.dto.stats.RegionCountDto;
import com.sch.rezero.repository.stats.StatsRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

@Service
@RequiredArgsConstructor
@Transactional(readOnly = true)
public class StatsService {
    private final StatsRepository statsRepository;
    private static final int TOP_REGION_LIMIT = 7;

    public Map<String, Double> getRegionCount() {
        List<RegionCountDto> regionCountList = statsRepository.countUsersByRegion();
        double allUser = statsRepository.allCountUsersByRegion().doubleValue();

        Map<String, Double> regionPercentageMap = new LinkedHashMap<>();
        double others = 0;
        for (int i = 0; i < regionCountList.size(); i++) {
            RegionCountDto regionCount = regionCountList.get(i);

            if (i < TOP_REGION_LIMIT) {
                regionPercentageMap.put(regionCount.region(), round((regionCount.count() / allUser) * 100));
            } else {
                others += regionCount.count();
            }
        }

        if (others > 0) {
            regionPercentageMap.put("기타", round((others / allUser) * 100));
        }
        return regionPercentageMap;
    }

    public Map<String, Double> getAgeGroupCount() {
        List<AgeGroupCountDto> ageGroupCountList = statsRepository.countUsersByAgeGroup();
        double allUser = statsRepository.allCountUsersByAge().doubleValue();

        Map<String, Double> regionPercentMap = new LinkedHashMap<>();
        for (AgeGroupCountDto r : ageGroupCountList) {
            regionPercentMap.put(r.ageGroup(), round((r.count() / allUser) * 100));
        }

        return regionPercentMap;
    }

    private double round(double value) {
        double scale = Math.pow(10, 1);
        return Math.round(value * scale) / scale;
    }
}