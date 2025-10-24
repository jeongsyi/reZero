package com.sch.rezero.controller.user;

import com.sch.rezero.config.S3Service;
import com.sch.rezero.dto.user.auth.LoginRequest;
import com.sch.rezero.dto.user.auth.LoginResponse;
import com.sch.rezero.dto.user.profile.ProfileCreateRequest;
import com.sch.rezero.dto.user.profile.ProfileResponse;
import com.sch.rezero.entity.user.User;
import com.sch.rezero.mapper.user.UserMapper;
import com.sch.rezero.service.user.LoginService;
import com.sch.rezero.service.user.ProfileService;
import jakarta.servlet.http.HttpSession;
import jakarta.validation.Valid;
import java.io.IOException;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

@RequiredArgsConstructor
@RestController
@RequestMapping("/api/auth")
public class LoginController {

  private final LoginService loginService;
  private final ProfileService profileService;
  private final UserMapper userMapper;
  private final S3Service s3Service;

  @PostMapping("/login")
  public ResponseEntity<LoginResponse> login(
      @RequestBody @Valid LoginRequest loginRequest,
      HttpSession session) {

    User user = loginService.login(loginRequest);
    session.setAttribute("user", user);

    LoginResponse login = userMapper.toLoginResponse(user);

    return ResponseEntity.status(HttpStatus.OK).body(login);
  }

  @PostMapping("/logout")
  public void logout(HttpSession session) {
    session.invalidate();
  }

  @PostMapping(path = "/signup", consumes = { MediaType.MULTIPART_FORM_DATA_VALUE })
  public ResponseEntity<ProfileResponse> signup(
      @RequestPart("request") @Valid ProfileCreateRequest profileCreateRequest,
      @RequestPart(name = "profileImage", required = false) MultipartFile profileImage
      ) throws IOException {

    String imageUrl = null;

    if (profileImage != null && !profileImage.isEmpty()) {
      imageUrl = s3Service.uploadFile(profileImage);  // ✅ S3 업로드 후 URL 생성
    }

    ProfileResponse created = profileService.create(profileCreateRequest, imageUrl);

    return ResponseEntity
        .status(HttpStatus.CREATED)
        .body(created);
  }

}
