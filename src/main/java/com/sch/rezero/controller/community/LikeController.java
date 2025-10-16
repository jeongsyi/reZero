package com.sch.rezero.controller.community;

import com.sch.rezero.config.UserContext;
import com.sch.rezero.dto.community.like.LikeQuery;
import com.sch.rezero.dto.community.like.LikeResponse;
import com.sch.rezero.dto.response.CursorPageResponse;
import com.sch.rezero.service.community.LikeService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RequiredArgsConstructor
@RestController
@RequestMapping("/api/likes")
public class LikeController {

  private final LikeService likeService;
  private final UserContext userContext;

  @PostMapping("{postId}")
  public ResponseEntity<LikeResponse> create(@PathVariable Long postId) {
    userContext.getCurrentUser();
    LikeResponse like = likeService.create(postId, userContext.getCurrentUserId());

    return ResponseEntity.status(HttpStatus.CREATED).body(like);
  }

  @GetMapping
  public ResponseEntity<CursorPageResponse<LikeResponse>> findByUser(LikeQuery query) {
    CursorPageResponse<LikeResponse> allByUserId = likeService.findAllByUserId(query);
    return ResponseEntity.status(HttpStatus.OK).body(allByUserId);
  }

  @DeleteMapping("/{likeId}")
  public ResponseEntity<Void> delete(@PathVariable Long likeId) {
    userContext.getCurrentUser();

    likeService.delete(userContext.getCurrentUserId(), likeId);

    return ResponseEntity.status(HttpStatus.OK).build();
  }

}
