package com.sch.rezero.repository.recycling;

import com.sch.rezero.entity.recycling.Scrap;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface ScrapPostRepository extends JpaRepository<Scrap, Long> {
}
