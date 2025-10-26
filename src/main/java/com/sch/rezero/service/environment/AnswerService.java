package com.sch.rezero.service.environment;

import com.sch.rezero.dto.environment.answer.AnswerResponse;
import com.sch.rezero.entity.environment.Answer;
import com.sch.rezero.mapper.environment.AnswerMapper;
import com.sch.rezero.repository.environment.AnswerRepository;
import java.util.List;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@RequiredArgsConstructor
public class AnswerService {

  private final AnswerRepository answerRepository;
  private final AnswerMapper answerMapper;

  @Transactional(readOnly = true)
  public List<AnswerResponse> findAll() {
    List<Answer> answers = answerRepository.findAll();

    return answers.stream().map(answerMapper::toAnswerResponse).toList();
  }

}
