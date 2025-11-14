package com.sch.rezero.mapper.missionCommunity;

import com.sch.rezero.dto.missionCommunity.missionComment.MissionCommentResponse;
import com.sch.rezero.entity.community.MissionPostComment;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;

@Mapper(componentModel = "spring")
public interface MissionPostCommentMapper {

  @Mapping(target = "parentId", source = "parent.id")
  @Mapping(target = "userId", source = "user.id")
  @Mapping(target = "userName", source = "user.name")
  @Mapping(target = "children", ignore = true)
  @Mapping(target = "profileUrl", source = "user.profileUrl")
  MissionCommentResponse toMissionCommentResponse(MissionPostComment missionPostComment);

}
