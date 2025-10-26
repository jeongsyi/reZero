package com.sch.rezero.controller.environment;

import com.sch.rezero.config.UserContext;
import com.sch.rezero.dto.environment.answer.AnswerResponse;
import com.sch.rezero.dto.environment.userAnswer.UserAnswerRequest;
import com.sch.rezero.dto.environment.userAnswer.UserAnswerResponse;
import com.sch.rezero.entity.user.User;
import com.sch.rezero.service.environment.AnswerService;
import com.sch.rezero.service.environment.UserAnswerService;
import java.util.List;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RequiredArgsConstructor
@RestController
@RequestMapping("/api/environment")
public class EnvironmentController {

  private final UserAnswerService userAnswerService;
  private final AnswerService answerService;
  private final UserContext userContext;

  @PostMapping
  public ResponseEntity<UserAnswerResponse> create(@RequestBody List<UserAnswerRequest> userAnswerRequests) {
    User user = userContext.getCurrentUserOrNull();

    if (user == null) {
      UserAnswerResponse answer = userAnswerService.createWithoutSaving(userAnswerRequests);
      return ResponseEntity.status(HttpStatus.OK).body(answer);
    }

    UserAnswerResponse answer = userAnswerService.create(userContext.getCurrentUserId(), userAnswerRequests);

    return ResponseEntity.status(HttpStatus.OK).body(answer);
  }

  @PostMapping("/redo")
  public ResponseEntity<UserAnswerResponse> update(@RequestBody List<UserAnswerRequest> userAnswerRequests) {
    userContext.getCurrentUser();
    UserAnswerResponse answer = userAnswerService.update(userContext.getCurrentUserId(), userAnswerRequests);

    return ResponseEntity.status(HttpStatus.OK).body(answer);
  }

  @GetMapping("/question")
  public ResponseEntity<List<AnswerResponse>> findAll() {
    List<AnswerResponse> answers = answerService.findAll();
    return ResponseEntity.status(HttpStatus.OK).body(answers);
  }
}
