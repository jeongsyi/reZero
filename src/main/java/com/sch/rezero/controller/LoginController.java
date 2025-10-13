package com.sch.rezero.controller;

import com.sch.rezero.dto.user.auth.LoginRequest;
import com.sch.rezero.dto.user.auth.LoginResponse;
import com.sch.rezero.dto.user.profile.ProfileCreateRequest;
import com.sch.rezero.dto.user.profile.ProfileResponse;
import com.sch.rezero.service.user.LoginService;
import com.sch.rezero.service.user.ProfileService;
import jakarta.servlet.http.HttpSession;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RequiredArgsConstructor
@RestController
@RequestMapping("/api/auth")
public class LoginController {

  private final LoginService loginService;
  private final ProfileService profileService;

  @PostMapping("/login")
  public ResponseEntity<LoginResponse> login(
      @RequestBody @Valid LoginRequest loginRequest,
      HttpSession session) {

    LoginResponse user = loginService.login(loginRequest);
    session.setAttribute("user", user);
    return ResponseEntity.ok(user);
  }

  @PostMapping("/logout")
  public void logout(HttpSession session) {
    session.invalidate();
  }

  @PostMapping("/signup")
  public ResponseEntity<ProfileResponse> signup(@RequestBody @Valid ProfileCreateRequest profileCreateRequest) {
    ProfileResponse profile = profileService.create(profileCreateRequest);

    return ResponseEntity
        .status(HttpStatus.CREATED)
        .body(profile);
  }

}
