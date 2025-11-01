package com.sch.rezero.repository.environment;

import com.sch.rezero.entity.environment.Question;
import java.util.List;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface QuestionRepository extends JpaRepository<Question, Long> {
  List<Question> findAllByOrderByOrderIndexAsc();
}
