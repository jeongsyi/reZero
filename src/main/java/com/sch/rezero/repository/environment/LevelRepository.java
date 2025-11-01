package com.sch.rezero.repository.environment;

import com.sch.rezero.entity.environment.Level;
import java.util.Optional;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

@Repository
public interface LevelRepository extends JpaRepository<Level, Long> {

  @Query("SELECT l FROM Level l WHERE :score BETWEEN l.min_score AND l.max_score")
  Optional<Level> findLevelByScore(@Param("score") int score);
}
