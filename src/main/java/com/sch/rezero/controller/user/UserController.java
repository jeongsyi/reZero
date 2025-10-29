package com.sch.rezero.controller.user;

import com.sch.rezero.config.S3Folder;
import com.sch.rezero.config.S3Service;
import com.sch.rezero.config.UserContext;
import com.sch.rezero.dto.user.profile.ProfileResponse;
import com.sch.rezero.dto.user.profile.ProfileUpdateRequest;
import com.sch.rezero.dto.user.profile.UserResponse;
import com.sch.rezero.entity.user.User;
import com.sch.rezero.service.user.ProfileService;
import com.sch.rezero.service.user.UserService;
import jakarta.validation.Valid;
import java.io.IOException;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PatchMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

@RequiredArgsConstructor
@RestController
@RequestMapping("/api")
public class UserController {

  private final ProfileService profileService;
  private final UserService userService;
  private final UserContext userContext;
  // 본인 프로필 (my page)
  @GetMapping("/me")
  public ResponseEntity<ProfileResponse> find() {
    userContext.getCurrentUser();
    ProfileResponse profile = profileService.find(userContext.getCurrentUserId());

    return ResponseEntity.status(HttpStatus.OK).body(profile);
  }

  @PatchMapping(path = "/me", consumes = {MediaType.MULTIPART_FORM_DATA_VALUE})
  public ResponseEntity<ProfileResponse> update(
      @RequestPart("request") @Valid ProfileUpdateRequest profileUpdateRequest,
      @RequestPart(name = "profileImage", required = false) MultipartFile profileImage)
      throws IOException {
    Long userId = userContext.getCurrentUserId();
    ProfileResponse updated = profileService.update(userId, profileUpdateRequest, profileImage);

    return ResponseEntity.status(HttpStatus.OK).body(updated);
  }

  @DeleteMapping("/me")
  public ResponseEntity<Void> delete() {
    profileService.delete(userContext.getCurrentUserId());
    return ResponseEntity.status(HttpStatus.OK).build();
  }

  // 프론트엔드 식별용
  @GetMapping("/users/me")
  public ResponseEntity<UserResponse> getCurrentUser() {
    Long userId = userContext.getCurrentUserId();
    UserResponse user = userService.findById(userId);
    return ResponseEntity.ok(user);
  }

  // 상대 프로필
  @GetMapping("/users/{userId}")
  public ResponseEntity<UserResponse> findById(@PathVariable long userId) {
    UserResponse user = userService.findById(userId);

    return ResponseEntity.status(HttpStatus.OK).body(user);
  }

}
