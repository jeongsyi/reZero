package com.sch.rezero.mapper.recycling;

import com.sch.rezero.dto.recycling.category.CategoryResponse;
import com.sch.rezero.entity.recycling.Category;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;

@Mapper(componentModel = "spring")
public interface CategoryMapper {
    @Mapping(source = "id", target = "categoryId")
    CategoryResponse toCategoryResponse(Category category);
}
