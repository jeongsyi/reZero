package com.sch.rezero.controller.community;

import com.sch.rezero.config.UserContext;
import com.sch.rezero.dto.community.communityComment.CommunityCommentCreateRequest;
import com.sch.rezero.dto.community.communityComment.CommunityCommentResponse;
import com.sch.rezero.entity.community.CommunityComment;
import com.sch.rezero.service.community.CommunityCommentService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
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
    CommunityCommentResponse created = communityCommentService.create(postId, userId, request);

    return ResponseEntity.status(HttpStatus.CREATED).body(created);
  }

}
