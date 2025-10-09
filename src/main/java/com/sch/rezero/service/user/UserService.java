package com.sch.rezero.service.user;

import com.sch.rezero.dto.user.profile.UserResponse;
import com.sch.rezero.entity.user.User;
import com.sch.rezero.mapper.user.UserMapper;
import com.sch.rezero.repository.user.FollowRepository;
import com.sch.rezero.repository.user.UserRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;
import org.springframework.web.server.ResponseStatusException;

@Service
@RequiredArgsConstructor
public class UserService {

    private final UserRepository userRepository;
    private final FollowRepository followRepository;
    private final UserMapper userMapper;

    public UserResponse findById(long id) {
        User user = userRepository.findById(id)
                .orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND, "User not found"));

        Integer followerCount = followRepository.countByFollower(user);
        Integer followingCount = followRepository.countByFollowing(user);

        return userMapper.toUserResponse(user, followerCount, followingCount);
    }

}
