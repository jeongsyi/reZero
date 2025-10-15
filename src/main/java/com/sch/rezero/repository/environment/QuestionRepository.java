package com.sch.rezero.repository.environment;

import com.sch.rezero.entity.environment.Question;
import org.springframework.data.jpa.repository.JpaRepository;

public interface QuestionRepository extends JpaRepository<Question, Long> {

}
