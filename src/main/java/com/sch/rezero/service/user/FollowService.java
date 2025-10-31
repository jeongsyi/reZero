package com.sch.rezero.service.user;

import com.sch.rezero.dto.response.CursorPageResponse;
import com.sch.rezero.dto.user.follow.FollowCreateRequest;
import com.sch.rezero.dto.user.follow.FollowDto;
import com.sch.rezero.dto.user.follow.FollowQuery;
import com.sch.rezero.dto.user.follow.FollowResponse;
import com.sch.rezero.entity.user.Follow;
import com.sch.rezero.entity.user.User;
import com.sch.rezero.mapper.user.FollowMapper;
import com.sch.rezero.repository.user.FollowRepository;
import com.sch.rezero.repository.user.UserRepository;
import jakarta.persistence.EntityNotFoundException;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

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

    @Transactional(readOnly = true)
    public CursorPageResponse<FollowDto> findAllFollowerByUserId(Long userId, FollowQuery query) {
        CursorPageResponse<Follow> result = followRepository.findAllFollowerByUserId(userId, query);
        List<FollowDto> contents = result.content().stream()
                .map(r -> new FollowDto(
                        r.getFollower().getId(),
                        r.getFollower().getName(),
                        r.getFollower().getProfileUrl(),
                        r.getCreatedAt())
                )
                .toList();

        return new CursorPageResponse<>(
                contents,
                result.nextCursor(),
                result.nextIdAfter(),
                result.size(),
                result.hasNext()
        );
    }

    @Transactional(readOnly = true)
    public CursorPageResponse<FollowDto> findAllFollowingByUserId(Long userId, FollowQuery query) {
        CursorPageResponse<Follow> result = followRepository.findAllFollowingByUserId(userId, query);
        List<FollowDto> contents = result.content().stream()
                .map(r -> new FollowDto(
                        r.getFollowing().getId(),
                        r.getFollowing().getName(),
                        r.getFollowing().getProfileUrl(),
                        r.getCreatedAt())
                )
                .toList();

        return new CursorPageResponse<>(
                contents,
                result.nextCursor(),
                result.nextIdAfter(),
                result.size(),
                result.hasNext()
        );
    }

    public void delete(Long userId, Long followId) {
        Follow follow = followRepository.findById(followId).orElseThrow(() -> new EntityNotFoundException("Follow not found"));

        if (!follow.getFollower().getId().equals(userId)) {
            throw new IllegalArgumentException("Follower and following are the same");
        }

        followRepository.delete(follow);
    }

}
