package com.sch.rezero.repository.recycling;

import com.sch.rezero.entity.recycling.RecyclingImage;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface RecyclingImageRepository extends JpaRepository<RecyclingImage, Long> {
}
