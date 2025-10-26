package com.sch.rezero.mapper.environment;

import com.sch.rezero.dto.environment.answer.AnswerResponse;
import com.sch.rezero.entity.environment.Answer;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;

@Mapper(componentModel = "spring")
public interface AnswerMapper {

  @Mapping(target = "question", source = "answer.question.question")
  AnswerResponse toAnswerResponse(Answer answer);

}
