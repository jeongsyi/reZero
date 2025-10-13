package com.sch.rezero.repository.user;

import com.sch.rezero.entity.user.User;
import java.util.List;
import java.util.Optional;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface UserRepository extends JpaRepository<User, Long> {

  Boolean existsByLoginId(String loginId);
  Optional<User> findByLoginId(String loginId);
}
