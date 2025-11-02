package com.sch.rezero.controller.community;

import com.sch.rezero.config.UserContext;
import com.sch.rezero.dto.community.communityPost.CommunityPostCreateRequest;
import com.sch.rezero.dto.community.communityPost.CommunityPostQuery;
import com.sch.rezero.dto.community.communityPost.CommunityPostResponse;
import com.sch.rezero.dto.community.communityPost.CommunityPostUpdateRequest;
import com.sch.rezero.dto.response.CursorPageResponse;
import com.sch.rezero.service.community.CommunityPostService;
import jakarta.validation.Valid;
import java.io.IOException;
import java.util.List;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PatchMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

@RequiredArgsConstructor
@RestController
@RequestMapping("/api/community-posts")
public class CommunityPostController {

  private final CommunityPostService communityPostService;
  private final UserContext userContext;

  @GetMapping
  public ResponseEntity<CursorPageResponse<CommunityPostResponse>> findAll(@ModelAttribute CommunityPostQuery query) {
    CursorPageResponse<CommunityPostResponse> communityPosts = communityPostService.findAll(query);
    return ResponseEntity.status(HttpStatus.OK).body(communityPosts);
  }

  @GetMapping("{postId}")
  public ResponseEntity<CommunityPostResponse> findByPost(@PathVariable long postId) {
    communityPostService.findByPostId(postId);
    return ResponseEntity.status(HttpStatus.OK).body(communityPostService.findByPostId(postId));
  }

  @GetMapping("/{userId}/posts")
  public ResponseEntity<List<CommunityPostResponse>> getUserPosts(@PathVariable Long userId) {
    List<CommunityPostResponse> posts = communityPostService.findByUser_Id(userId);
    return ResponseEntity.status(HttpStatus.OK).body(posts);
  }


  @PostMapping(consumes = MediaType.MULTIPART_FORM_DATA_VALUE)
  public ResponseEntity<CommunityPostResponse> create(
      @RequestPart("request") @Valid CommunityPostCreateRequest request,
      @RequestPart(value = "images", required = false) List<MultipartFile> images
      ) throws IOException {
    Long userId = userContext.getCurrentUserId();
    CommunityPostResponse created = communityPostService.create(userId, request, images);

    return ResponseEntity.status(HttpStatus.CREATED).body(created);
  }

  @PatchMapping("{postId}")
  public ResponseEntity<CommunityPostResponse> update(
      @PathVariable long postId,
      @RequestPart @Valid CommunityPostUpdateRequest request,
      @RequestPart(value = "images", required = false) List<MultipartFile> images)
      throws IOException {
    Long userId = userContext.getCurrentUserId();

    CommunityPostResponse updated = communityPostService.update(userId, postId, request, images);

    return ResponseEntity.status(HttpStatus.OK).body(updated);
  }

  @DeleteMapping("{postId}")
  public ResponseEntity<Void> delete(@PathVariable long postId) {
    Long userId = userContext.getCurrentUserId();
    communityPostService.delete(userId, postId);
    return ResponseEntity.status(HttpStatus.OK).build();
  }

  @GetMapping("/feed")
  public ResponseEntity<CursorPageResponse<CommunityPostResponse>> getFollowingFeed(
      @ModelAttribute CommunityPostQuery query) {
    Long userId = userContext.getCurrentUserId();
    CursorPageResponse<CommunityPostResponse> feed = communityPostService.findFollowingFeed(userId, query);
    return ResponseEntity.ok(feed);
  }


}
