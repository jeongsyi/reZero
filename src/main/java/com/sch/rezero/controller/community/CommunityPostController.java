package com.sch.rezero.controller.community;

import com.sch.rezero.dto.community.communityPost.CommunityPostQuery;
import com.sch.rezero.dto.community.communityPost.CommunityPostResponse;
import com.sch.rezero.dto.response.CursorPageResponse;
import com.sch.rezero.service.community.CommunityPostService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RequiredArgsConstructor
@RestController
@RequestMapping("/api/community-posts")
public class CommunityPostController {

  private final CommunityPostService communityPostService;

  @GetMapping
  public ResponseEntity<CursorPageResponse<CommunityPostResponse>> findAll(CommunityPostQuery query) {
    CursorPageResponse<CommunityPostResponse> communityPosts = communityPostService.findAll(query);
    return ResponseEntity.status(HttpStatus.OK).body(communityPosts);
  }

  @GetMapping("{postId}")
  public ResponseEntity<CommunityPostResponse> findByPost(@PathVariable long postId) {
    communityPostService.findByPostId(postId);
    return ResponseEntity.status(HttpStatus.OK).body(communityPostService.findByPostId(postId));
  }



}
