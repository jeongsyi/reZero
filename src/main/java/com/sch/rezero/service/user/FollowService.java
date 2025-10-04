package com.sch.rezero.service.user;

import com.sch.rezero.dto.user.follow.FollowCreateRequest;
import com.sch.rezero.dto.user.follow.FollowResponse;
import com.sch.rezero.dto.user.profile.UserResponse;
import com.sch.rezero.entity.user.Follow;
import com.sch.rezero.entity.user.User;
import com.sch.rezero.mapper.user.FollowMapper;
import com.sch.rezero.mapper.user.UserMapper;
import com.sch.rezero.repository.user.FollowRepository;
import com.sch.rezero.repository.user.UserRepository;
import jakarta.persistence.EntityNotFoundException;
import java.util.Optional;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@RequiredArgsConstructor
public class FollowService {

  private final FollowRepository followRepository;
  private final UserRepository userRepository;
  private final FollowMapper followMapper;

  @Transactional
  public FollowResponse create(Long id, FollowCreateRequest followCreateRequest) {

    User follower = userRepository.findById(id)
        .orElseThrow(() -> new EntityNotFoundException("User not found"));

    User following = userRepository.findById(followCreateRequest.followingId())
        .orElseThrow(() -> new EntityNotFoundException("Following not found"));

    if (follower.equals(following)) {
      throw new IllegalArgumentException("Follower and following are the same");
    }

    if (followRepository.existsByFollowerAndFollowing(follower, following)) {
      throw new IllegalArgumentException("Follower and following are the same");
    }

    Follow follow = new Follow(follower, following);
    followRepository.save(follow);

    return followMapper.toFollowResponse(follow);
  }

  public void delete(Long followerId, Long followingId) {
    User follower = userRepository.findById(followerId)
        .orElseThrow(() -> new EntityNotFoundException("User not found"));

    User following = userRepository.findById(followingId)
        .orElseThrow(() -> new EntityNotFoundException("Following not found"));

    if (!followRepository.existsByFollowerAndFollowing(follower, following)) {
      throw new IllegalArgumentException("Follower and following are not the same");
    }

    followRepository.deleteByFollowerAndFollowing(follower, following);
  }

}
