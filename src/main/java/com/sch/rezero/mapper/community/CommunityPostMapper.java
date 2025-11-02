package com.sch.rezero.mapper.community;

import com.sch.rezero.dto.community.communityPost.CommunityPostResponse;
import com.sch.rezero.entity.community.CommunityPost;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;

@Mapper(componentModel = "spring")
public interface CommunityPostMapper {

  @Mapping(target = "userName", source = "user.name")
  @Mapping(target = "userId", source = "user.id")
  @Mapping(target = "likeCount", expression = "java(communityPost.getLikes().size())")
  @Mapping(target = "commentCount", expression = "java(communityPost.getComments().size())")
  @Mapping(target = "imageUrls", expression = "java(communityPost.getImages().stream().map(image -> image.getImageUrl()).toList())")
  CommunityPostResponse toCommunityPostResponse(CommunityPost communityPost);
}
