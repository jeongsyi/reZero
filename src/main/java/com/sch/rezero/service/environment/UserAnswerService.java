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
  public UserAnswerResponse create(Long userId, List<UserAnswerRequest> requests) {
    return saveOrUpdate(userId, requests, false);
  }


  @Transactional(readOnly = true)
  public UserAnswerResponse createWithoutSaving(List<UserAnswerRequest> userAnswerRequests) {
    List<Long> answerIds = userAnswerRequests.stream()
        .map(UserAnswerRequest::answerId)
        .toList();

    List<Answer> answers = answerRepository.findAllById(answerIds);

    if (answers.size() != answerIds.size()) {
      throw new NoSuchElementException("Some answers not found");
    }

    int totalScore = answers.stream()
        .mapToInt(Answer::getScore)
        .sum();

    String level = levelRepository.findLevelByScore(totalScore)
        .map(Level::getName)
        .orElseThrow(() -> new NoSuchElementException("Level not found"));

    return userAnswerMapper.toUserAnswerResponse(level, totalScore);
  }


  @Transactional
  public UserAnswerResponse update(Long userId, List<UserAnswerRequest> requests) {
    return saveOrUpdate(userId, requests, true);
  }

  private UserAnswerResponse saveOrUpdate(Long userId, List<UserAnswerRequest> requests, boolean isUpdate) {
    // 1️⃣ 유저 검증
    User user = validateUserId(userId);

    if (isUpdate) {
      userAnswerRepository.deleteAllByUserId(user.getId());
    }

    List<Long> answerIds = requests.stream()
        .map(UserAnswerRequest::answerId)
        .toList();

    List<Answer> answers = answerRepository.findAllById(answerIds);

    if (answers.size() != answerIds.size()) {
      throw new NoSuchElementException("Some answers not found");
    }

    int totalScore = answers.stream()
        .mapToInt(Answer::getScore)
        .sum();

    List<UserAnswer> userAnswers = answers.stream()
        .map(answer -> new UserAnswer(answer, user))
        .toList();

    userAnswerRepository.saveAll(userAnswers);

    String level = levelRepository.findLevelByScore(totalScore)
        .map(Level::getName)
        .orElseThrow(() -> new NoSuchElementException("Level not found"));

    return userAnswerMapper.toUserAnswerResponse(level, totalScore);
  }


  private User validateUserId(Long userId) {
    return userRepository.findById(userId)
        .orElseThrow(NoSuchElementException::new);
  }
}
