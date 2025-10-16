package com.sch.rezero.repository.user;

import com.sch.rezero.entity.user.Follow;
import com.sch.rezero.entity.user.User;
import org.springframework.data.repository.CrudRepository;

public interface FollowRepository extends CrudRepository<Follow, Long> {

  boolean existsByFollowerAndFollowing(User follower, User following);

  Integer countByFollower(User follower);
  Integer countByFollowing(User following);

}
