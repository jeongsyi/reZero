package com.sch.rezero.controller.environment;

import com.sch.rezero.config.UserContext;
import com.sch.rezero.dto.environment.QuestionResponse;
import com.sch.rezero.dto.environment.ResultResponse;
import com.sch.rezero.dto.environment.UserAnswerRequest;
import com.sch.rezero.service.environment.EnvironmentTestService;
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
@RequestMapping("api/environment")
public class EnvironmentTestController {

  private final EnvironmentTestService environmentTestService;
  private final UserContext userContext;

  @GetMapping("/questions")
  public ResponseEntity<List<QuestionResponse>> findAllQuestions() {
    List<QuestionResponse> questions = environmentTestService.findAllQuestion();
    return ResponseEntity.status(HttpStatus.OK).body(questions);
  }

  @PostMapping("/submit")
  public ResponseEntity<ResultResponse> submit(@RequestBody UserAnswerRequest userAnswerRequest) {
    Long userId = null;
    try {
      userId = userContext.getCurrentUserId();
    } catch (Exception ignored) {

    }
    ResultResponse userAnswers = environmentTestService.submit(userId, userAnswerRequest.answers());
    return ResponseEntity.status(HttpStatus.OK).body(userAnswers);
  }

  @GetMapping("/level/me")
  public ResponseEntity<ResultResponse> getCurrentUserLevel() {
    Long userId = userContext.getCurrentUserId();
    ResultResponse result = environmentTestService.findById(userId);
    return ResponseEntity.status(HttpStatus.OK).body(result);
  }

}
