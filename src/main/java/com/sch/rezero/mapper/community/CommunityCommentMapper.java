package com.sch.rezero.mapper.community;

import com.sch.rezero.dto.community.communityComment.CommunityCommentResponse;
import com.sch.rezero.entity.community.CommunityComment;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;

@Mapper(componentModel = "spring")
public interface CommunityCommentMapper {
  @Mapping(source = "parent.id", target = "parentId")
  @Mapping(source = "user.id", target = "userId")
  @Mapping(target = "userName", source = "user.name")
  @Mapping(target = "children", ignore = true)
  @Mapping(source = "user.profileUrl", target = "profileUrl")
  CommunityCommentResponse toCommunityCommentResponse(CommunityComment comment);
}
