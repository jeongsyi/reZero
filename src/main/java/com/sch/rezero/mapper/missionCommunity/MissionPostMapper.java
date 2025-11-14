package com.sch.rezero.mapper.missionCommunity;

import com.sch.rezero.dto.missionCommunity.missionPost.MissionPostResponse;
import com.sch.rezero.entity.community.MissionPost;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;

@Mapper(componentModel = "spring")
public interface MissionPostMapper {

  @Mapping(target = "authorName", source = "user.name")
  @Mapping(target = "userId", source = "user.id")
  @Mapping(target = "commentCount", expression = "java(missionPost.getComments().size())")
  @Mapping(target = "likeCount", expression = "java(missionPost.getLikes().size())")
  @Mapping(target = "imageUrls", expression = "java(missionPost.getImages().stream().map(image -> image.getImageUrl()).toList())")
  MissionPostResponse toMissionPostResponse(MissionPost missionPost);

}
