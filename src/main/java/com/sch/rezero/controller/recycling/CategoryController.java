package com.sch.rezero.controller.recycling;

import com.sch.rezero.dto.recycling.category.CategoryCreateRequest;
import com.sch.rezero.dto.recycling.category.CategoryResponse;
import com.sch.rezero.dto.recycling.category.CategoryUpdateRequest;
import com.sch.rezero.service.recycling.CategoryService;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RequiredArgsConstructor
@RestController
@RequestMapping("api/category")
public class CategoryController {
    private final CategoryService categoryService;

    @GetMapping
    public ResponseEntity<List<CategoryResponse>> findAll() {
        List<CategoryResponse> categories = categoryService.findAll();
        return ResponseEntity.status(HttpStatus.OK).body(categories);
    }

    @PostMapping
    public ResponseEntity<CategoryResponse> create(@RequestBody @Valid CategoryCreateRequest request) {
        CategoryResponse categoryResponse = categoryService.create(request);
        return ResponseEntity.status(HttpStatus.CREATED).body(categoryResponse);
    }

    @PatchMapping("/{id}")
    public ResponseEntity<CategoryResponse> update(@PathVariable Long id, @RequestBody @Valid CategoryUpdateRequest request) {
        CategoryResponse categoryResponse = categoryService.update(id, request);
        return ResponseEntity.status(HttpStatus.OK).body(categoryResponse);
    }

    @DeleteMapping("/{id}")
    public void delete(@PathVariable Long id) {
        categoryService.delete(id);
    }
}