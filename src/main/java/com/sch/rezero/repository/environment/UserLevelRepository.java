package com.sch.rezero.repository.environment;

import com.sch.rezero.entity.environment.UserLevel;
import java.util.Optional;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface UserLevelRepository extends JpaRepository<UserLevel, Long> {
  Optional<UserLevel> findByUserId(Long userId);
}
