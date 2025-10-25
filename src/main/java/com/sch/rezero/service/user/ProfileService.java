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

        String finalProfileUrl = user.getProfileUrl(); // 현재 DB에 저장된 URL로 초기화

        // =============================================
        // ⭐️ 이미지 처리 로직
        // =============================================

        // 1. 새 파일이 존재하는 경우 (업로드 및 기존 파일 삭제)
        if (profileImage != null && !profileImage.isEmpty()) {
            // 기존 파일이 있다면 S3에서 삭제
            if (finalProfileUrl != null && !finalProfileUrl.isEmpty()) {
                s3Service.deleteFile(finalProfileUrl);
            }
            // 새 파일 업로드
            finalProfileUrl = s3Service.uploadFile(profileImage, S3Folder.PROFILE.getName());

        }
        // 2. 파일이 없고, 명시적으로 삭제 요청이 온 경우
        else if (Boolean.TRUE.equals(profileUpdateRequest.deleteProfileImage())) {
            // 기존 파일이 있다면 S3에서 삭제
            if (finalProfileUrl != null && !finalProfileUrl.isEmpty()) {
                s3Service.deleteFile(finalProfileUrl);
            }
            // DB URL을 null로 설정
            finalProfileUrl = null;
        }
        // 3. 파일도 없고, 삭제 요청도 없는 경우 (finalProfileUrl은 기존 값 유지)
        //    이 경우 finalProfileUrl은 초기값(user.getProfileUrl())을 유지합니다.

        // =============================================
        // ⭐️ 사용자 정보 업데이트
        // =============================================

        user.update(
            profileUpdateRequest.userId(),
            profileUpdateRequest.password(),
            profileUpdateRequest.name(),
            finalProfileUrl, // 처리된 최종 URL 전달
            profileUpdateRequest.birth(),
            profileUpdateRequest.region()
        );

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
