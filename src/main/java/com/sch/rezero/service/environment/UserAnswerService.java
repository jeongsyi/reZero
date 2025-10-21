package com.sch.rezero.service.environment;

import com.sch.rezero.dto.environment.userAnswer.UserAnswerRequest;
import com.sch.rezero.dto.environment.userAnswer.UserAnswerResponse;
import com.sch.rezero.entity.environment.Answer;
import com.sch.rezero.entity.environment.Level;
import com.sch.rezero.entity.environment.UserAnswer;
import com.sch.rezero.entity.user.User;
import com.sch.rezero.mapper.environment.UserAnswerMapper;
import com.sch.rezero.repository.environment.AnswerRepository;
import com.sch.rezero.repository.environment.LevelRepository;
import com.sch.rezero.repository.environment.UserAnswerRepository;
import com.sch.rezero.repository.user.UserRepository;
import java.util.ArrayList;
import java.util.List;
import java.util.NoSuchElementException;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@RequiredArgsConstructor
public class UserAnswerService {

  private final UserAnswerRepository userAnswerRepository;
  private final UserRepository userRepository;
  private final AnswerRepository answerRepository;
  private final LevelRepository levelRepository;
  private final UserAnswerMapper userAnswerMapper;

  @Transactional
  public UserAnswerResponse create(Long userId, List<UserAnswerRequest> userAnswerRequests) {
    User user = validateUserId(userId);

    int totalScore = 0;
    List<UserAnswer> userAnswers = new ArrayList<>();

    for (UserAnswerRequest req : userAnswerRequests) {
      Answer answer = answerRepository.findById(req.answerId())
          .orElseThrow(() -> new NoSuchElementException("Answer with id " + req.answerId() + " not found"));

      userAnswers.add(new UserAnswer(answer, user));
      totalScore += answer.getScore();
    }

    userAnswerRepository.saveAll(userAnswers);
    userAnswerRepository.flush();

    String level = levelRepository.findLevelByScore(totalScore)
        .map(Level::getName).orElseThrow(() -> new NoSuchElementException("Level not found"));

    return userAnswerMapper.toUserAnswerResponse(level, totalScore);
  }

  @Transactional
  public UserAnswerResponse createWithoutSaving(List<UserAnswerRequest> userAnswerRequests) {
    int totalScore = 0;

    for (UserAnswerRequest req : userAnswerRequests) {
      Answer answer = answerRepository.findById(req.answerId())
          .orElseThrow(() -> new NoSuchElementException("Answer with id " + req.answerId() + " not found"));

      totalScore += answer.getScore();
    }

    String level = levelRepository.findLevelByScore(totalScore)
        .map(Level::getName).orElseThrow(() -> new NoSuchElementException("Level not found"));

    return userAnswerMapper.toUserAnswerResponse(level, totalScore);
  }

  @Transactional
  public UserAnswerResponse update(Long userId, List<UserAnswerRequest> userAnswerRequests) {
    User user = validateUserId(userId);

    userAnswerRepository.deleteAllByUserId(user.getId());

    int totalScore = 0;

    for (UserAnswerRequest req : userAnswerRequests) {
      Answer answer = answerRepository.findById(req.answerId())
          .orElseThrow(
              () -> new NoSuchElementException("Answer with id " + req.answerId() + " not found"));

      UserAnswer userAnswer = new UserAnswer(answer, user);
      userAnswerRepository.save(userAnswer);

      totalScore += answer.getScore();
    }

    String level = levelRepository.findLevelByScore(totalScore)
        .map(Level::getName).orElseThrow(() -> new NoSuchElementException("Level not found"));

    return userAnswerMapper.toUserAnswerResponse(level, totalScore);
  }


  private User validateUserId(Long userId) {
    return userRepository.findById(userId).orElseThrow(NoSuchElementException::new);
  }



}
