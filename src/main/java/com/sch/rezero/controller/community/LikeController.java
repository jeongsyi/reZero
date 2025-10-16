package com.sch.rezero.controller.community;

import com.sch.rezero.config.UserContext;
import com.sch.rezero.dto.community.like.LikeResponse;
import com.sch.rezero.entity.community.Like;
import com.sch.rezero.entity.user.User;
import com.sch.rezero.mapper.community.LikeMapper;
import com.sch.rezero.service.community.LikeService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RequiredArgsConstructor
@RestController
@RequestMapping("/api/likes")
public class LikeController {

  private final LikeService likeService;
  private final UserContext userContext;
  private final LikeMapper likeMapper;

  @PostMapping("{postId}")
  public ResponseEntity<LikeResponse> create(@PathVariable Long postId) {
    userContext.getCurrentUser();
    LikeResponse like = likeService.create(postId, userContext.getCurrentUserId());

    return ResponseEntity.status(HttpStatus.CREATED).body(like);
  }

  @DeleteMapping
  public ResponseEntity<Void> delete(@PathVariable Long postId) {
    userContext.getCurrentUser();

    likeService.delete(userContext.getCurrentUserId(), postId);

    return ResponseEntity.status(HttpStatus.OK).build();
  }

}
