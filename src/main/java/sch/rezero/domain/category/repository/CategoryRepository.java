package sch.rezero.domain.category.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import sch.rezero.domain.category.entity.Category;

@Repository
public interface CategoryRepository extends JpaRepository<Category, Long> {

    boolean existsByCategoryAndDeletedAtIsNull(String category);

    boolean existsByCategoryAndIdNotAndDeletedAtIsNull(String category, Long id);
}
