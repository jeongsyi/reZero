package com.sch.rezero.service.user;

import com.sch.rezero.dto.response.CursorPageResponse;
import com.sch.rezero.dto.user.profile.UserQuery;
import com.sch.rezero.dto.user.profile.UserResponse;
import com.sch.rezero.entity.user.User;
import com.sch.rezero.mapper.user.UserMapper;
import com.sch.rezero.repository.user.FollowRepository;
import com.sch.rezero.repository.user.UserRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.server.ResponseStatusException;

import java.util.List;

@Service
@RequiredArgsConstructor
public class UserService {

    private final UserRepository userRepository;
    private final FollowRepository followRepository;
    private final UserMapper userMapper;

    public UserResponse findById(long id) {
        User user = userRepository.findById(id)
                .orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND, "User not found"));

        Integer followerCount = followRepository.countByFollowing(user);
        Integer followingCount = followRepository.countByFollower(user);

        return userMapper.toUserResponse(user, followerCount, followingCount);
    }

    @Transactional(readOnly = true)
    public CursorPageResponse<UserResponse> findAll(UserQuery query) {
        CursorPageResponse<User> result = userRepository.findAllUser(query);
        List<UserResponse> contents = result.content().stream()
                .map(u -> userMapper.toUserResponse(u, Math.toIntExact(u.getFollowerCount()), Math.toIntExact(u.getFollowingCount())))
                .toList();

        return new CursorPageResponse<>(
                contents,
                result.nextCursor(),
                result.nextIdAfter(),
                result.size(),
                result.hasNext()
        );
    }

}
