package com.sch.rezero.repository.user;

import com.sch.rezero.entity.community.CommunityPost;
import com.sch.rezero.entity.user.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface UserRepository extends JpaRepository<User, Long>, UserQueryRepository {

    Boolean existsByLoginId(String loginId);

    Optional<User> findByLoginId(String loginId);

    Optional<CommunityPost> findByName(String name);
}
