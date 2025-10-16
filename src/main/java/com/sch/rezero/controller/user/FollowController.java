package com.sch.rezero.controller.user;

import com.sch.rezero.config.UserContext;
import com.sch.rezero.dto.user.follow.FollowCreateRequest;
import com.sch.rezero.dto.user.follow.FollowResponse;
import com.sch.rezero.service.user.FollowService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RequiredArgsConstructor
@RestController
@RequestMapping("api/follows")
public class FollowController {

  private final FollowService followService;
  private final UserContext userContext;

  @PostMapping
  public ResponseEntity<FollowResponse> create(FollowCreateRequest followCreateRequest) {
    Long userId = userContext.getCurrentUserId();
    FollowResponse created = followService.create(userId, followCreateRequest);

    return ResponseEntity.status(HttpStatus.CREATED).body(created);
  }

  @DeleteMapping("{id}")
  public ResponseEntity<Void> delete(@PathVariable long id) {
    Long userId = userContext.getCurrentUserId();
    followService.delete(userId, id);

    return ResponseEntity.status(HttpStatus.NO_CONTENT).build();
  }

}
