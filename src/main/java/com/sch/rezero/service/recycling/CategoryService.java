package com.sch.rezero.service.recycling;

import com.sch.rezero.dto.recycling.category.CategoryCreateRequest;
import com.sch.rezero.dto.recycling.category.CategoryResponse;
import com.sch.rezero.dto.recycling.category.CategoryUpdateRequest;
import com.sch.rezero.entity.recycling.Category;
import com.sch.rezero.mapper.recycling.CategoryMapper;
import com.sch.rezero.repository.recycling.CategoryRepository;
import com.sch.rezero.repository.recycling.RecyclingPostRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.NoSuchElementException;

@Service
@RequiredArgsConstructor
public class CategoryService {
    private final CategoryRepository categoryRepository;
    private final CategoryMapper categoryMapper;
    private final RecyclingPostRepository recyclingPostRepository;

    @Transactional
    public CategoryResponse create(CategoryCreateRequest categoryCreateRequest) {
        if (categoryRepository.existsByCategory(categoryCreateRequest.category())) {
            throw new IllegalStateException("해당 카테고리는 이미 존재합니다");
        }

        Category category = new Category(categoryCreateRequest.category());

        categoryRepository.save(category);
        return categoryMapper.toCategoryResponse(category);
    }

    @Transactional(readOnly = true)
    public CategoryResponse find(Long categoryId) {
        Category category = categoryRepository.findById(categoryId).orElseThrow(NoSuchElementException::new);
        return categoryMapper.toCategoryResponse(category);
    }

    @Transactional(readOnly = true)
    public List<CategoryResponse> findAll() {
        return categoryRepository.findAll().stream()
                .map(categoryMapper::toCategoryResponse)
                .toList();
    }

    @Transactional
    public CategoryResponse update(Long categoryId, CategoryUpdateRequest categoryUpdateRequest) {
        Category category = categoryRepository.findById(categoryId).orElseThrow(NoSuchElementException::new);
        category.update(categoryUpdateRequest.category());
        return categoryMapper.toCategoryResponse(category);
    }

    @Transactional
    public void delete(Long categoryId) {
        Category category = categoryRepository.findById(categoryId).orElseThrow(NoSuchElementException::new);

        if (recyclingPostRepository.existsByCategory(category)) {
            throw new IllegalStateException("해당 카테고리를 사용하는 게시글이 있어 삭제할 수 없습니다");
        }

        categoryRepository.delete(category);
    }
}