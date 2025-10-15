package com.sch.rezero.repository.environment;

import com.sch.rezero.entity.environment.UserAnswer;
import org.springframework.data.jpa.repository.JpaRepository;

public interface UserAnswerRepository extends JpaRepository<UserAnswer, Long> {

  void deleteAllByUserId(Long userId);

}
