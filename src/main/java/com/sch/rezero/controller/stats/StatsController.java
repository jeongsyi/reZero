package com.sch.rezero.controller.stats;

import com.sch.rezero.service.stats.StatsScheduler;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.Map;

@RequiredArgsConstructor
@RestController
@RequestMapping("/api/stats")
public class StatsController {
    private final StatsScheduler statsScheduler;

    @GetMapping("/region")
    public ResponseEntity<Map<String, Double>> region() {
        return ResponseEntity.status(HttpStatus.OK).body(statsScheduler.getRegionStats());
    }

    @GetMapping("/age")
    public ResponseEntity<Map<String, Double>> age() {
        return ResponseEntity.status(HttpStatus.OK).body(statsScheduler.getAgeGroupStats());
    }
}