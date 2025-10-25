package com.sch.rezero.service.user;

import com.sch.rezero.config.S3Folder;
import com.sch.rezero.config.S3Service;
import com.sch.rezero.dto.user.profile.ProfileCreateRequest;
import com.sch.rezero.dto.user.profile.ProfileResponse;
import com.sch.rezero.dto.user.profile.ProfileUpdateRequest;
import com.sch.rezero.entity.user.User;
import com.sch.rezero.mapper.user.UserMapper;
import com.sch.rezero.repository.user.FollowRepository;
import com.sch.rezero.repository.user.UserRepository;
import java.io.IOException;
import java.util.Optional;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.server.ResponseStatusException;

@Service
@RequiredArgsConstructor
public class ProfileService {

    private final UserRepository userRepository;
    private final FollowRepository followRepository;
    private final UserMapper userMapper;
    private final S3Service s3Service;

    @Transactional
    public ProfileResponse create(ProfileCreateRequest userCreateRequest, MultipartFile profileImage) throws IOException {
        if (userRepository.existsByLoginId(userCreateRequest.userId())) {
            throw new ResponseStatusException(HttpStatus.BAD_REQUEST, "LoginId already exists");
        }

        String profileUrl = null;

        if (profileImage != null && !profileImage.isEmpty()) {
            profileUrl = s3Service.uploadFile(profileImage, S3Folder.PROFILE.getName());
        }

        User user = new User(userCreateRequest.userId(), userCreateRequest.password(), userCreateRequest.name(),
                userCreateRequest.role(), profileUrl, userCreateRequest.birth(), userCreateRequest.region());

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
    public ProfileResponse update(Long id, ProfileUpdateRequest profileUpdateRequest, MultipartFile profileImage) throws IOException {
        User user = userRepository.findById(id)
                .orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND, "User not found"));

        if (userRepository.existsByLoginId(profileUpdateRequest.userId())
            && !user.getLoginId().equals(profileUpdateRequest.userId())) {
            throw new ResponseStatusException(HttpStatus.BAD_REQUEST, "LoginId already exists");
        }

        String profileUrl = user.getProfileUrl();

        if (profileImage != null && !profileImage.isEmpty()) {
            if (profileUrl != null && !profileUrl.isEmpty()) {
                s3Service.deleteFile(profileUrl);
            }

            profileUrl = s3Service.uploadFile(profileImage, S3Folder.PROFILE.getName());
        }

        user.update(profileUpdateRequest.userId(), profileUpdateRequest.password(),
                profileUpdateRequest.name(),
                profileUrl, profileUpdateRequest.birth(),
                profileUpdateRequest.region());

        Integer followerCount = followRepository.countByFollower(user);
        Integer followingCount = followRepository.countByFollowing(user);

        return userMapper.toProfileResponse(user, followerCount, followingCount);
    }

    @Transactional
    public void delete(Long id) {
        User user = userRepository.findById(id).orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND, "User not found"));

        String profileUrl = user.getProfileUrl();

        if (profileUrl != null && !profileUrl.isEmpty()) {
            s3Service.deleteFile(profileUrl);
        }

        userRepository.deleteById(id);
    }


}
