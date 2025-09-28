package com.sch.rezero.repository.recycling;

import com.sch.rezero.entity.recycling.RecyclingPost;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface RecyclingPostRepository extends JpaRepository<RecyclingPost, Long> {
}
