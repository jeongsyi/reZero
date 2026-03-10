package sch.rezero.domain.category.mapper;

import org.mapstruct.Mapper;
import sch.rezero.domain.category.dto.response.CategoryResponse;
import sch.rezero.domain.category.entity.Category;

@Mapper(componentModel = "spring")
public interface CategoryMapper {

    CategoryResponse toDto(Category category);
}
