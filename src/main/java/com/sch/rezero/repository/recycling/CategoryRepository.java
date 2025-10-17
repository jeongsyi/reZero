package com.sch.rezero.repository.recycling;

import com.sch.rezero.entity.recycling.Category;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface CategoryRepository extends JpaRepository<Category, Long> {
    boolean existsByCategory(String category);
    Category findByCategory(String category);
}
