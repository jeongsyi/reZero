package com.sch.rezero.service.user;

import com.sch.rezero.dto.user.profile.ProfileCreateRequest;
import com.sch.rezero.dto.user.profile.ProfileResponse;
import com.sch.rezero.dto.user.profile.ProfileUpdateRequest;
import com.sch.rezero.entity.user.User;
import com.sch.rezero.mapper.user.UserMapper;
import com.sch.rezero.repository.user.FollowRepository;
import com.sch.rezero.repository.user.UserRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.server.ResponseStatusException;

@Service
@RequiredArgsConstructor
public class ProfileService {

    private final UserRepository userRepository;
    private final FollowRepository followRepository;
    private final UserMapper userMapper;

    @Transactional
    public ProfileResponse create(ProfileCreateRequest userCreateRequest) {
        if (userRepository.existsByLoginId(userCreateRequest.userId())) {
            throw new ResponseStatusException(HttpStatus.BAD_REQUEST, "LoginId already exists");
        }

        User user = new User(userCreateRequest.userId(), userCreateRequest.password(), userCreateRequest.name(),
                userCreateRequest.role(), userCreateRequest.profileUrl(), userCreateRequest.birth(), userCreateRequest.region());

        userRepository.save(user);

        return userMapper.toProfileResponse(user, 0, 0);
    }

    @Transactional(readOnly = true)
    public ProfileResponse find(long id) {
        User user = userRepository.findById(id)
                .orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND, "User not found"));

        Integer followerCount = followRepository.countByFollowing(user);
        Integer followingCount = followRepository.countByFollower(user);

        return userMapper.toProfileResponse(user, followerCount, followingCount);
    }

    @Transactional
    public ProfileResponse update(Long id, ProfileUpdateRequest profileUpdateRequest) {
        User user = userRepository.findById(id)
                .orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND, "User not found"));

        if (userRepository.existsByLoginId(profileUpdateRequest.userId())) {
            throw new ResponseStatusException(HttpStatus.BAD_REQUEST, "LoginId already exists");
        }
        user.update(profileUpdateRequest.userId(), profileUpdateRequest.password(),
                profileUpdateRequest.name(),
                profileUpdateRequest.profileUrl(), profileUpdateRequest.birth(),
                profileUpdateRequest.region());

        Integer followerCount = followRepository.countByFollower(user);
        Integer followingCount = followRepository.countByFollowing(user);

        return userMapper.toProfileResponse(user, followerCount, followingCount);
    }

    @Transactional
    public void delete(Long id) {
        if (!userRepository.existsById(id)) {
            throw new ResponseStatusException(HttpStatus.NOT_FOUND, "User not found");
        }

        userRepository.deleteById(id);
    }


}
