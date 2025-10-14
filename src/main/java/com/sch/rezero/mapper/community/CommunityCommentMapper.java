package com.sch.rezero.mapper.community;

import com.sch.rezero.dto.community.communityComment.CommunityCommentResponse;
import com.sch.rezero.entity.community.CommunityComment;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;

@Mapper(componentModel = "spring")
public interface CommunityCommentMapper {
  @Mapping(source = "parent.id", target = "parentId")
  @Mapping(target = "userName", source = "user.name")
  CommunityCommentResponse toCommunityCommentResponse(CommunityComment comment);
}
