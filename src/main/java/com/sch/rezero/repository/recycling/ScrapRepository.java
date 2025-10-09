package com.sch.rezero.repository.recycling;

import com.sch.rezero.entity.recycling.Scrap;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ScrapRepository extends JpaRepository<Scrap, Long>, ScrapQueryRepository {
    boolean existsByPostIdAndUserId(Long postId, Long userId);
    List<Scrap> findAllByPostId(Long postId);
}
