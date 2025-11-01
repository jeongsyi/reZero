package com.sch.rezero.mapper.environment;

import com.sch.rezero.dto.environment.ResultResponse;
import com.sch.rezero.entity.environment.UserLevel;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;

@Mapper(componentModel = "spring")
public interface ResultMapper {

  @Mapping(target = "userId", source = "user.id")
  @Mapping(target = "levelName", source = "level.name")
  @Mapping(target = "description", source = "level.description")
  ResultResponse toResultResponse(UserLevel userLevel);

}
