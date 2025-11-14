package com.sch.rezero.controller.missionCommunity;

import com.sch.rezero.config.UserContext;
import com.sch.rezero.dto.missionCommunity.like.LikeQuery;
import com.sch.rezero.dto.missionCommunity.like.MissionLikeResponse;
import com.sch.rezero.dto.response.CursorPageResponse;
import com.sch.rezero.service.missionCommunity.MissionPostLikeService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/mission/likes")
@RequiredArgsConstructor
public class MissionPostLikeController {

  private final MissionPostLikeService missionPostLikeService;
  private final UserContext userContext;

  @PostMapping("/{postId}")
  public ResponseEntity<MissionLikeResponse> like(@PathVariable Long postId) {
    Long userId = userContext.getCurrentUserId();
    MissionLikeResponse response = missionPostLikeService.like(postId, userId);
    return ResponseEntity.ok(response);
  }
//
  @DeleteMapping("/{postId}")
  public ResponseEntity<Void> unlike(@PathVariable Long postId) {
    Long userId = userContext.getCurrentUserId();
    missionPostLikeService.unlike(postId, userId);
    return ResponseEntity.noContent().build();
  }

  @GetMapping
  public ResponseEntity<CursorPageResponse<MissionLikeResponse>> findByUser(@ModelAttribute LikeQuery query) {
    CursorPageResponse<MissionLikeResponse> all = missionPostLikeService.findAll(
        userContext.getCurrentUserId(), query);

    return ResponseEntity.status(HttpStatus.OK).body(all);

  }

  @GetMapping("/status/{postId}")
  public ResponseEntity<Boolean> isLiked(@PathVariable Long postId) {
    Long userId = userContext.getCurrentUserId();
    boolean liked = missionPostLikeService.isLiked(postId, userId);
    return ResponseEntity.ok(liked);
  }
}
