package com.sch.rezero.mapper.recycling;

import com.sch.rezero.dto.recycling.qnaComment.QnaCommentResponse;
import com.sch.rezero.entity.recycling.QnaComment;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;

@Mapper(componentModel = "spring")
public interface QnaCommentMapper {
    @Mapping(source = "parent.id", target = "parentId")
    @Mapping(source = "user.name", target = "username")
    QnaCommentResponse toQnaCommentResponse(QnaComment qnaComment);
}
