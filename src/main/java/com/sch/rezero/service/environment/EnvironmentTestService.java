package com.sch.rezero.service.environment;

import static com.sch.rezero.entity.user.QUser.user;

import com.sch.rezero.dto.environment.QuestionResponse;
import com.sch.rezero.dto.environment.ResultResponse;
import com.sch.rezero.entity.environment.Level;
import com.sch.rezero.entity.environment.Question;
import com.sch.rezero.entity.environment.UserLevel;
import com.sch.rezero.repository.environment.AnswerRepository;
import com.sch.rezero.repository.environment.LevelRepository;
import com.sch.rezero.repository.environment.QuestionRepository;
import com.sch.rezero.repository.environment.UserLevelRepository;
import com.sch.rezero.repository.user.UserRepository;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@RequiredArgsConstructor
public class EnvironmentTestService {
  private final QuestionRepository questionRepository;
  private final AnswerRepository answerRepository;
  private final LevelRepository levelRepository;
  private final UserLevelRepository userLevelRepository;
  private final UserRepository userRepository;

  @Transactional(readOnly = true)
  public List<QuestionResponse> findAllQuestion() {
    List<Question> questions = questionRepository.findAllByOrderByOrderIndexAsc();
    return questions.stream()
        .map(q -> new QuestionResponse(
            q.getId(),
            q.getQuestion(),
            q.getOrderIndex(),
            q.getAnswers().stream().
                map(a -> new QuestionResponse.AnswerOption(
                    a.getId(),
                    a.getAnswer(),
                    a.getScore(),
                    a.getOrder_index()))
                .collect(Collectors.toList())
        ))
        .collect(Collectors.toList());
  }

  @Transactional
  public ResultResponse submit(Long userId, List<Long> answerIds) {
    int totalScore = answerRepository.findAllById(answerIds)
        .stream().mapToInt(a -> a.getScore()).sum();

    Level level = levelRepository.findLevelByScore(totalScore)
        .orElseThrow(() -> new IllegalArgumentException("Level not found"));


    if (userId == null) {
      return new ResultResponse(
          null,
          totalScore,
          level.getName(),
          level.getDescription()
      );
    }

    var user = userRepository.findById(userId)
        .orElseThrow(() -> new IllegalArgumentException("User not found"));

    UserLevel userLevel = userLevelRepository.findByUserId(userId)
        .orElse(new UserLevel(null, user, level, totalScore));

    userLevel.setLevel(level);
    userLevel.setTotal_score(totalScore);
    userLevelRepository.save(userLevel);

    return new ResultResponse(
        user.getId(),
        totalScore,
        level.getName(),
        level.getDescription()
    );
  }

  @Transactional
  public ResultResponse findById(Long userId) {
    UserLevel userLevel = userLevelRepository.findByUserId(userId)
        .orElseThrow(() -> new IllegalArgumentException("User not found"));

    Level level = userLevel.getLevel();
    return new ResultResponse(
        userId,
        userLevel.getTotal_score(),
        level.getName(),
        level.getDescription()
    );
  }

}
