package com.sch.rezero.mapper.user;

import com.sch.rezero.dto.user.profile.ProfileResponse;
import com.sch.rezero.dto.user.profile.UserResponse;
import com.sch.rezero.entity.user.User;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;

@Mapper(componentModel = "spring")
public interface UserMapper {

  @Mapping(source = "id", target = "userId")
  UserResponse toUserResponse(User user, Integer followerCount, Integer followingCount);

  @Mapping(source = "id", target = "userId")
  ProfileResponse toProfileResponse(User user);
}
