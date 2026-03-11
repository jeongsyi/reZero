package sch.rezero.domain.category.service;

import java.util.List;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import sch.rezero.config.exception.ApiException;
import sch.rezero.domain.category.dto.request.CategoryCreateRequest;
import sch.rezero.domain.category.dto.request.CategoryUpdateRequest;
import sch.rezero.domain.category.dto.response.CategoryResponse;
import sch.rezero.domain.category.entity.Category;
import sch.rezero.domain.category.exception.CategoryErrorCode;
import sch.rezero.domain.category.mapper.CategoryMapper;
import sch.rezero.domain.category.repository.CategoryRepository;

@Service
@RequiredArgsConstructor
public class CategoryService {

    private final CategoryRepository categoryRepository;
    private final CategoryMapper categoryMapper;

    @Transactional
    public CategoryResponse create(CategoryCreateRequest request) {
        if (categoryRepository.existsByCategoryAndDeletedAtIsNull(request.category())) {
            throw new ApiException(CategoryErrorCode.DUPLICATE_CATEGORY_NAME);
        }

        Category category = Category.builder()
                                    .category(request.category())
                                    .build();

        return categoryMapper.toDto(categoryRepository.save(category));
    }

    @Transactional(readOnly = true)
    public CategoryResponse findById(Long id) {
        Category category = categoryRepository.findById(id)
                                              .orElseThrow(
                                                  () -> new ApiException(CategoryErrorCode.CATEGORY_NOT_FOUND));

        if (category.getDeletedAt() != null) {
            throw new ApiException(CategoryErrorCode.CATEGORY_DELETED);
        }

        return categoryMapper.toDto(category);
    }

    //TODO : 추후 페이지네이션으로 구현
    @Transactional(readOnly = true)
    public List<CategoryResponse> findAll() {
        return categoryRepository.findAll()
                                 .stream()
                                 .map(categoryMapper::toDto)
                                 .toList();
    }

    @Transactional
    public CategoryResponse update(Long id, CategoryUpdateRequest request) {
        Category category = categoryRepository.findById(id)
                                              .orElseThrow(
                                                  () -> new ApiException(CategoryErrorCode.CATEGORY_NOT_FOUND));

        if (category.getDeletedAt() != null) {
            throw new ApiException(CategoryErrorCode.CATEGORY_DELETED);
        }

        if (categoryRepository.existsByCategoryAndIdNot(request.category(), id)) {
            throw new ApiException(CategoryErrorCode.DUPLICATE_CATEGORY_NAME);
        }

        category.updateCategory(request);
        return categoryMapper.toDto(categoryRepository.save(category));
    }

    @Transactional
    public CategoryResponse softDelete(Long id) {
        Category category = categoryRepository.findById(id)
                                              .orElseThrow(
                                                  () -> new ApiException(CategoryErrorCode.CATEGORY_NOT_FOUND));

        if (category.getDeletedAt() != null) {
            throw new ApiException(CategoryErrorCode.CATEGORY_DELETED);
        }

        category.softDelete();
        return categoryMapper.toDto(category);
    }

    @Transactional
    public void hardDelete(Long id) {
        Category category = categoryRepository.findById(id)
                                              .orElseThrow(
                                                  () -> new ApiException(CategoryErrorCode.CATEGORY_NOT_FOUND));
        categoryRepository.delete(category);
    }
}
