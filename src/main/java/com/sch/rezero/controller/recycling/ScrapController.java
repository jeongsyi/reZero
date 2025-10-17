package com.sch.rezero.controller.recycling;

import com.sch.rezero.config.UserContext;
import com.sch.rezero.dto.recycling.scrap.ScrapQuery;
import com.sch.rezero.dto.recycling.scrap.ScrapResponse;
import com.sch.rezero.dto.response.CursorPageResponse;
import com.sch.rezero.service.recycling.ScrapService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RequiredArgsConstructor
@RestController
@RequestMapping("/api/scraps")
public class ScrapController {
    private final ScrapService scrapService;
    private final UserContext userContext;

    @GetMapping
    public ResponseEntity<CursorPageResponse<ScrapResponse>> findAll(@ModelAttribute ScrapQuery query) {
        var scraps = scrapService.findAllByUserId(userContext.getCurrentUserId(),query);
        return ResponseEntity.status(HttpStatus.OK).body(scraps);
    }

    @PostMapping("/{postId}")
    public ResponseEntity<ScrapResponse> create(@PathVariable Long postId) {
        ScrapResponse scrap = scrapService.create(userContext.getCurrentUserId(), postId);
        return ResponseEntity.status(HttpStatus.CREATED).body(scrap);
    }

    @DeleteMapping("/{postId}")
    public void delete(@PathVariable Long postId) {
        scrapService.delete(userContext.getCurrentUserId(), postId);
    }
}