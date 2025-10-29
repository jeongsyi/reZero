package com.sch.rezero.controller.community;

import com.sch.rezero.config.UserContext;
import com.sch.rezero.dto.community.communityComment.CommunityCommentCreateRequest;
import com.sch.rezero.dto.community.communityComment.CommunityCommentResponse;
import com.sch.rezero.dto.community.communityComment.CommunityCommentUpdateRequest;
import com.sch.rezero.service.community.CommunityCommentService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.PatchMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RequiredArgsConstructor
@RestController
@RequestMapping("api/comments")
public class CommunityCommentController {

  private final CommunityCommentService communityCommentService;
  private final UserContext userContext;

  @PostMapping("{postId}")
  public ResponseEntity<CommunityCommentResponse> create(
      @PathVariable Long postId,
      @RequestBody CommunityCommentCreateRequest request
  ) {
    Long userId = userContext.getCurrentUserId();
    CommunityCommentResponse created = communityCommentService.create(userId, postId, request);

    return ResponseEntity.status(HttpStatus.CREATED).body(created);
  }

  @PatchMapping("{id}")
  public ResponseEntity<CommunityCommentResponse> update(
      @PathVariable Long id,
      @RequestBody CommunityCommentUpdateRequest request
  ) {
    Long userId = userContext.getCurrentUserId();
    CommunityCommentResponse updated = communityCommentService.update(id, userId, request);

    return ResponseEntity.status(HttpStatus.OK).body(updated);
  }

  @DeleteMapping("{id}")
  public ResponseEntity<Void> delete(@PathVariable Long id) {
    Long userId = userContext.getCurrentUserId();
    communityCommentService.delete(id, userId);

    return ResponseEntity.status(HttpStatus.OK).build();
  }
}
