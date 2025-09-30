package com.sch.rezero.repository.recycling;

import com.sch.rezero.entity.recycling.Category;
import com.sch.rezero.entity.recycling.RecyclingPost;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface RecyclingPostRepository extends JpaRepository<RecyclingPost, Long> {
    List<RecyclingPost> findAllByUserId(Long userId);
    boolean existsByCategory(Category category);
}
