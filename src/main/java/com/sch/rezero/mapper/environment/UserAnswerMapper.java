package com.sch.rezero.mapper.environment;

import com.sch.rezero.dto.environment.userAnswer.UserAnswerResponse;
import com.sch.rezero.entity.environment.UserAnswer;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;

@Mapper(componentModel = "spring")
public interface UserAnswerMapper {

  UserAnswerResponse toUserAnswerResponse(String level, int totalScore);
}
