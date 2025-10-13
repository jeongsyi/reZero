package com.sch.rezero.controller;

import com.sch.rezero.dto.user.profile.ProfileResponse;
import com.sch.rezero.dto.user.profile.ProfileUpdateRequest;
import com.sch.rezero.entity.user.User;
import com.sch.rezero.service.user.ProfileService;
import com.sch.rezero.service.user.UserService;
import jakarta.servlet.http.HttpSession;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PatchMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RequiredArgsConstructor
@RestController
@RequestMapping("/api/me")
public class ProfileController {

  private final ProfileService profileService;
  private final UserService userService;

  @GetMapping
  public ResponseEntity<ProfileResponse> find(HttpSession session) {
    User user = (User) session.getAttribute("user");

    ProfileResponse profile = profileService.find(user.getId());

    return ResponseEntity.status(HttpStatus.OK).body(profile);
  }

  @PatchMapping
  public ResponseEntity<ProfileResponse> update(
      @RequestBody @Valid ProfileUpdateRequest profileUpdateRequest,
      HttpSession session) {
    User user = (User) session.getAttribute("user");

    ProfileResponse updated = profileService.update(user.getId(), profileUpdateRequest);
    return ResponseEntity.status(HttpStatus.OK).body(updated);
  }

  @DeleteMapping
  public void delete(HttpSession session) {
    User user = (User) session.getAttribute("user");
    profileService.delete(user.getId());
  }

}
