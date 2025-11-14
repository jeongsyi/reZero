package com.sch.rezero.mapper.missionCommunity;

import com.sch.rezero.dto.missionCommunity.like.MissionLikeResponse;
import com.sch.rezero.entity.community.MissionPostLike;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;

@Mapper(componentModel = "spring")
public interface MissionLikeMapper {

  @Mapping(target = "postId", source = "missionPost.id")
  @Mapping(target = "userId", source = "user.id")
  MissionLikeResponse toMissionLikeResponse(MissionPostLike missionPostLike);

}
