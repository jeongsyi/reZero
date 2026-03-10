package sch.rezero.domain.category.controller;

import java.util.List;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PatchMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import sch.rezero.domain.category.dto.request.CategoryCreateRequest;
import sch.rezero.domain.category.dto.request.CategoryUpdateRequest;
import sch.rezero.domain.category.dto.response.CategoryResponse;
import sch.rezero.domain.category.service.CategoryService;

@RestController
@RequestMapping("/api/categories")
@RequiredArgsConstructor
public class CategoryController {

    private final CategoryService categoryService;

    @GetMapping("/{categoryId}")
    public ResponseEntity<CategoryResponse> getCategory(@PathVariable Long categoryId) {
        CategoryResponse category = categoryService.findById(categoryId);
        return ResponseEntity.status(HttpStatus.OK)
                             .body(category);
    }

    @GetMapping
    public ResponseEntity<List<CategoryResponse>> getCategories() {
        List<CategoryResponse> categories = categoryService.findAll();
        return ResponseEntity.status(HttpStatus.OK)
                             .body(categories);
    }

    @PostMapping
    public ResponseEntity<CategoryResponse> createCategory(@RequestBody CategoryCreateRequest request) {
        CategoryResponse category = categoryService.create(request);
        return ResponseEntity.status(HttpStatus.CREATED)
                             .body(category);
    }

    @PatchMapping("/{categoryId}")
    public ResponseEntity<CategoryResponse> updateCategory(@PathVariable Long categoryId,
        @RequestBody CategoryUpdateRequest request) {
        CategoryResponse category = categoryService.update(request, categoryId);
        return ResponseEntity.status(HttpStatus.OK)
                             .body(category);
    }

    @DeleteMapping("/{categoryId}")
    public ResponseEntity<CategoryResponse> deleteCategory(@PathVariable Long categoryId) {
        CategoryResponse category = categoryService.softDelete(categoryId);
        return ResponseEntity.status(HttpStatus.OK)
                             .body(category);
    }

    @DeleteMapping("/{categoryId}/hard")
    public void hardDeleteCategory(@PathVariable Long categoryId) {
        categoryService.hardDelete(categoryId);
    }
}
