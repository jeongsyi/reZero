package com.sch.rezero.controller.missionCommunity;

import com.sch.rezero.config.UserContext;
import com.sch.rezero.dto.missionCommunity.missionComment.MissionCommentCreateRequest;
import com.sch.rezero.dto.missionCommunity.missionComment.MissionCommentQuery;
import com.sch.rezero.dto.missionCommunity.missionComment.MissionCommentResponse;
import com.sch.rezero.dto.missionCommunity.missionComment.MissionCommentUpdateRequest;
import com.sch.rezero.dto.response.CursorPageResponse;
import com.sch.rezero.service.missionCommunity.MissionPostCommentService;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RequiredArgsConstructor
@RestController
@RequestMapping("api/mission/comments")
public class MissionPostCommentController {

  private final MissionPostCommentService missionPostCommentService;
  private final UserContext userContext;

  @PostMapping("/{postId}")
  public ResponseEntity<MissionCommentResponse> createComment(
      @PathVariable Long postId,
      @Valid @RequestBody MissionCommentCreateRequest request
  ) {
    Long userId = userContext.getCurrentUserId();
    MissionCommentResponse response = missionPostCommentService.create(userId, postId, request);
    return ResponseEntity.ok(response);
  }

  @GetMapping("/{postId}")
  public ResponseEntity<CursorPageResponse<MissionCommentResponse>> getComments(
      @PathVariable Long postId,
      @ModelAttribute MissionCommentQuery query
  ) {
    CursorPageResponse<MissionCommentResponse> response = missionPostCommentService.findAll(postId, query);
    return ResponseEntity.ok(response);
  }

  @PutMapping("/{commentId}")
  public ResponseEntity<MissionCommentResponse> updateComment(
      @PathVariable Long commentId,
      @Valid @RequestBody MissionCommentUpdateRequest request
  ) {
    Long userId = userContext.getCurrentUserId();
    MissionCommentResponse response = missionPostCommentService.update(commentId, userId, request);
    return ResponseEntity.ok(response);
  }

  @DeleteMapping("/{commentId}")
  public ResponseEntity<Void> deleteComment(@PathVariable Long commentId) {
    Long userId = userContext.getCurrentUserId();
    missionPostCommentService.delete(commentId, userId);
    return ResponseEntity.noContent().build();
  }

}
