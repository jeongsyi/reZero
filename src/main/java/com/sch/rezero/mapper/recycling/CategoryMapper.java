package com.sch.rezero.mapper.recycling;

import com.sch.rezero.dto.recycling.category.CategoryResponse;
import com.sch.rezero.entity.recycling.Category;
import org.mapstruct.Mapper;

@Mapper(componentModel = "spring")
public interface CategoryMapper {
    CategoryResponse toCategoryResponse(Category category);
}
