package com.sch.rezero.mapper.recycling;

import com.sch.rezero.dto.recycling.recyclingPost.RecyclingPostResponse;
import com.sch.rezero.entity.recycling.RecyclingPost;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;

@Mapper(componentModel = "spring")
public interface RecyclingPostMapper {
    @Mapping(source = "category.category", target = "category")
    @Mapping(source = "user.name", target = "userName")
    @Mapping(target = "imageUrls", expression = "java(recyclingPost.getImages().stream().map(image -> image.getImageUrl()).toList())")
    @Mapping(target = "commentCount", expression = "java(recyclingPost.getComments().size())")
    @Mapping(target = "scrapCount", expression = "java(recyclingPost.getScraps().size())")
    RecyclingPostResponse toRecyclingResponse(RecyclingPost recyclingPost);
}
