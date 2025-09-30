package com.sch.rezero.mapper.community;

import com.sch.rezero.dto.community.likes.LikeResponse;
import com.sch.rezero.entity.community.Like;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;

@Mapper(componentModel = "spring")
public interface LikeMapper {

  @Mapping(source = "communityPost.id", target = "postId")
  @Mapping(source = "user.id", target = "userId")
  LikeResponse toLikeResponse(Like like);

}
