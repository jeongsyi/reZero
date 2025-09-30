package com.sch.rezero.mapper.recycling;

import com.sch.rezero.dto.recycling.scrap.ScrapResponse;
import com.sch.rezero.entity.recycling.Scrap;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;

@Mapper(componentModel = "spring")
public interface ScrapMapper {
    @Mapping(source = "post.id", target = "postId")
    @Mapping(source = "user.id", target = "userId")
    ScrapResponse toResponse(Scrap scrap);
}
