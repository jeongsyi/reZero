package com.sch.rezero.mapper.environment;

import com.sch.rezero.dto.environment.userAnswer.UserAnswerResponse;
import org.mapstruct.Mapper;

@Mapper(componentModel = "spring")
public interface UserAnswerMapper {

  UserAnswerResponse toUserAnswerResponse(String level, int totalScore);
}
