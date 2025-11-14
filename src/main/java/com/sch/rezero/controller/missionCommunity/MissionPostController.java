package com.sch.rezero.controller.missionCommunity;

import com.sch.rezero.config.UserContext;
import com.sch.rezero.dto.missionCommunity.missionPost.MissionPostCreateRequest;
import com.sch.rezero.dto.missionCommunity.missionPost.MissionPostQuery;
import com.sch.rezero.dto.missionCommunity.missionPost.MissionPostResponse;
import com.sch.rezero.dto.missionCommunity.missionPost.MissionPostUpdateRequest;
import com.sch.rezero.dto.response.CursorPageResponse;
import com.sch.rezero.service.missionCommunity.MissionPostService;
import jakarta.validation.Valid;
import java.io.IOException;
import java.util.List;
import lombok.RequiredArgsConstructor;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

@RestController
@RequiredArgsConstructor
@RequestMapping("/api/mission-posts")
public class MissionPostController {

  private final MissionPostService missionPostService;
  private final UserContext userContext;

  // 유저

  @PostMapping(consumes = MediaType.MULTIPART_FORM_DATA_VALUE)
  public ResponseEntity<MissionPostResponse> createMissionPost(
      @Valid @RequestPart("data") MissionPostCreateRequest request,
      @RequestPart(value = "images") List<MultipartFile> images
  ) throws IOException {
    Long userId = userContext.getCurrentUserId();
    MissionPostResponse response = missionPostService.create(userId, request, images);
    return ResponseEntity.ok(response);
  }

  @GetMapping("/{postId}")
  public ResponseEntity<MissionPostResponse> getMissionPost(@PathVariable Long postId) {
    return ResponseEntity.ok(missionPostService.findById(postId));
  }

  @GetMapping("/approved")
  public ResponseEntity<CursorPageResponse<MissionPostResponse>> getApprovedPosts(@ModelAttribute MissionPostQuery query) {
    return ResponseEntity.ok(missionPostService.findApproved(query));
  }

  @GetMapping("/user/{userId}")
  public ResponseEntity<List<MissionPostResponse>> getUserPosts(@PathVariable Long userId) {
    return ResponseEntity.ok(missionPostService.findByUser(userId));
  }

  @PatchMapping(value = "/{postId}", consumes = MediaType.MULTIPART_FORM_DATA_VALUE)
  public ResponseEntity<MissionPostResponse> updateMissionPost(
      @PathVariable Long postId,
      @Valid @RequestPart("data") MissionPostUpdateRequest request,
      @RequestPart(value = "images", required = false) List<MultipartFile> images
  ) throws IOException {
    Long userId = userContext.getCurrentUserId();
    MissionPostResponse response = missionPostService.update(userId, postId, request, images);
    return ResponseEntity.ok(response);
  }

  @DeleteMapping("/{postId}")
  public ResponseEntity<Void> deleteMissionPost(@PathVariable Long postId) {
    Long userId = userContext.getCurrentUserId();
    missionPostService.delete(userId, postId);
    return ResponseEntity.noContent().build();
  }

  // 관리자

  @GetMapping("/pending")
  public ResponseEntity<CursorPageResponse<MissionPostResponse>> getPendingPosts(@ModelAttribute MissionPostQuery query) {
    return ResponseEntity.ok(missionPostService.findPendingPosts(query));
  }

  @GetMapping("/rejected")
  public ResponseEntity<CursorPageResponse<MissionPostResponse>> getRejectedPosts(@ModelAttribute MissionPostQuery query) {
    return ResponseEntity.ok(missionPostService.findRejectedPosts(query));
  }

  @PatchMapping("/{postId}/approve")
  public ResponseEntity<Void> approveMissionPost(@PathVariable Long postId) {
    Long userId = userContext.getCurrentUserId();
    missionPostService.approve(userId, postId);

    return ResponseEntity.noContent().build();
  }

  @PatchMapping("/{postId}/reject")
  public ResponseEntity<Void> rejectMissionPost(@PathVariable Long postId) {
    Long userId = userContext.getCurrentUserId();
    missionPostService.reject(userId, postId);

    return ResponseEntity.noContent().build();
  }
}
