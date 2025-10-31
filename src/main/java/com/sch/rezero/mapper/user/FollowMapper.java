package com.sch.rezero.mapper.user;

import com.sch.rezero.dto.user.follow.FollowResponse;
import com.sch.rezero.entity.user.Follow;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;

@Mapper(componentModel = "spring")
public interface FollowMapper {

  @Mapping(source = "follow.following.id", target = "followingId")
  FollowResponse toFollowResponse(Follow follow, Boolean subscribedByMe);

}
