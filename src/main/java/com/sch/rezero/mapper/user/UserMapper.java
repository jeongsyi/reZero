package com.sch.rezero.mapper.user;

import com.sch.rezero.dto.user.profile.ProfileResponse;
import com.sch.rezero.dto.user.profile.UserResponse;
import com.sch.rezero.entity.user.User;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;

@Mapper(componentModel = "spring")
public interface UserMapper {

  @Mapping(target = "userId", source = "user.loginId")
  UserResponse toUserResponse(User user, Integer followerCount, Integer followingCount);

  @Mapping(target = "userId", source = "user.loginId")
  ProfileResponse toProfileResponse(User user, Integer followerCount, Integer followingCount);
}
