package com.sch.rezero.controller;

import com.sch.rezero.dto.environment.userAnswer.UserAnswerRequest;
import com.sch.rezero.dto.environment.userAnswer.UserAnswerResponse;
import com.sch.rezero.entity.user.User;
import com.sch.rezero.service.environment.UserAnswerService;
import jakarta.servlet.http.HttpSession;
import java.util.List;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RequiredArgsConstructor
@RestController
@RequestMapping("api/environment")
public class EnvironmentController {

  private final UserAnswerService userAnswerService;

  @PostMapping
  public ResponseEntity<UserAnswerResponse> create(
      @RequestBody List<UserAnswerRequest> userAnswerRequests,
      HttpSession session
  ) {
    User user = (User) session.getAttribute("user");
    Long userId = (user != null) ? user.getId() : null;

    if (userId == null) {

    }

    UserAnswerResponse answer = userAnswerService.create(userId, userAnswerRequests);
    return ResponseEntity.status(HttpStatus.OK).body(answer);
  }
}
