package com.sch.rezero.service.missionCommunity;

import com.sch.rezero.config.S3Folder;
import com.sch.rezero.config.S3Service;
import com.sch.rezero.dto.missionCommunity.missionPost.MissionPostCreateRequest;
import com.sch.rezero.dto.missionCommunity.missionPost.MissionPostQuery;
import com.sch.rezero.dto.missionCommunity.missionPost.MissionPostResponse;
import com.sch.rezero.dto.missionCommunity.missionPost.MissionPostUpdateRequest;
import com.sch.rezero.dto.response.CursorPageResponse;
import com.sch.rezero.entity.community.Mission;
import com.sch.rezero.entity.community.MissionPost;
import com.sch.rezero.entity.community.MissionPostImage;
import com.sch.rezero.entity.notification.Notification;
import com.sch.rezero.entity.user.Role;
import com.sch.rezero.entity.user.User;
import com.sch.rezero.event.NotificationEvent;
import com.sch.rezero.mapper.missionCommunity.MissionPostMapper;
import com.sch.rezero.repository.missionCommunity.MissionPostRepository;
import com.sch.rezero.repository.missionCommunity.MissionRepository;
import com.sch.rezero.repository.user.UserRepository;
import jakarta.persistence.EntityNotFoundException;
import java.io.IOException;
import java.util.List;
import java.util.NoSuchElementException;
import lombok.RequiredArgsConstructor;
import org.springframework.context.ApplicationEventPublisher;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

@Service
@RequiredArgsConstructor
public class MissionPostService {

  private final MissionPostRepository missionPostRepository;
  private final UserRepository userRepository;
  private final MissionRepository missionRepository;
  private final MissionPostMapper missionPostMapper;
  private final S3Service s3Service;
  private final MissionStampService stampService;
  private final ApplicationEventPublisher applicationEventPublisher;

  @Transactional
  public MissionPostResponse create(Long userId, MissionPostCreateRequest request, List<MultipartFile> images)
      throws IOException {

    User user = validateUser(userId);
    Mission mission = missionRepository.findActiveMission()
        .orElseThrow(() -> new IllegalStateException("현재 진행 중인 미션이 없습니다."));

    MissionPost missionPost = new MissionPost(request.title(), request.description(), mission, user);
    missionPost.pending();
    missionPostRepository.save(missionPost);

    if (images == null || images.isEmpty()) {
      throw new IllegalArgumentException("사진 인증은 필수입니다.");
    }

    for (MultipartFile file : images) {
      String imageUrl = s3Service.uploadFile(file, S3Folder.MISSION.getName());
      MissionPostImage image = new MissionPostImage(missionPost, imageUrl);
      missionPost.addImage(image);
    }

    return missionPostMapper.toMissionPostResponse(missionPost);
  }

  @Transactional(readOnly = true)
  public MissionPostResponse findById(Long postId) {
    MissionPost post = validatePost(postId);
    return missionPostMapper.toMissionPostResponse(post);
  }

  @Transactional(readOnly = true)
  public CursorPageResponse<MissionPostResponse> findApproved(MissionPostQuery query) {
    return findByStatus(query, "APPROVED");
  }

  @Transactional(readOnly = true)
  public List<MissionPostResponse> findByUser(Long userId) {
    return missionPostRepository.findByUserId(userId).stream()
        .map(missionPostMapper::toMissionPostResponse)
        .toList();
  }

  @Transactional
  public MissionPostResponse update(Long userId, Long postId, MissionPostUpdateRequest request,
      List<MultipartFile> newImages) throws IOException {

    MissionPost post = validatePost(postId);
    if (!post.getUser().getId().equals(userId)) {
      throw new EntityNotFoundException("작성자만 수정할 수 있습니다.");
    }

    if (newImages != null) {
      for (MissionPostImage old : List.copyOf(post.getImages())) {
        if (old.getImageUrl() != null && !old.getImageUrl().isEmpty()) {
          s3Service.deleteFile(old.getImageUrl());
        }
        post.deleteImage(old);
      }

      for (MultipartFile file : newImages) {
        if (file != null && !file.isEmpty()) {
          String imageUrl = s3Service.uploadFile(file, S3Folder.MISSION.getName());
          MissionPostImage image = new MissionPostImage(post, imageUrl);
          post.addImage(image);
        }
      }
    }

    post.update(request.title(), request.description());
    return missionPostMapper.toMissionPostResponse(post);
  }

  @Transactional
  public void delete(Long userId, Long postId) {
    MissionPost post = validatePost(postId);
    if (!post.getUser().getId().equals(userId)) {
      throw new EntityNotFoundException("작성자만 삭제할 수 있습니다.");
    }

    post.getImages().forEach(image -> {
      if (image.getImageUrl() != null && !image.getImageUrl().isEmpty()) {
        s3Service.deleteFile(image.getImageUrl());
      }
    });

    missionPostRepository.delete(post);
  }

  @Transactional(readOnly = true)
  public CursorPageResponse<MissionPostResponse> findPendingPosts(MissionPostQuery query) {
    return findByStatus(query, "PENDING");
  }

  @Transactional(readOnly = true)
  public CursorPageResponse<MissionPostResponse> findRejectedPosts(MissionPostQuery query) {
    return findByStatus(query, "REJECTED");
  }

  @Transactional
  public void approve(Long userId, Long postId) {
    User user = validateUser(userId);
    if (user.getRole() == Role.USER) {
      throw new EntityNotFoundException("사용자는 승인할 수 없습니다.");
    }

    MissionPost post = validatePost(postId);
    post.approve();

    applicationEventPublisher.publishEvent(
        new NotificationEvent(
            this,
            post.getUser().getId(),
            user.getId(),
            Notification.Type.APPROVED,
            "회원님의 미션 인증이 승인되었습니다!",
            post.getId()
        )
    );

    stampService.stampMission(post.getMission(), post.getUser());
  }

  @Transactional
  public void reject(Long userId, Long postId) {
    User user = validateUser(userId);
    if (user.getRole() == Role.USER) {
      throw new EntityNotFoundException("사용자는 승인할 수 없습니다.");
    }

    MissionPost post = validatePost(postId);
    post.reject();

    applicationEventPublisher.publishEvent(
        new NotificationEvent(
            this,
            post.getUser().getId(),
            user.getId(),
            Notification.Type.REJECTED,
            "회원님의 미션 인증이 거절되었습니다. 다시 시도해보세요!",
            post.getId()
        )
    );

    stampService.unstampMission(post.getMission(), post.getUser());
  }


  private User validateUser(Long userId) {
    return userRepository.findById(userId)
        .orElseThrow(() -> new NoSuchElementException("유저를 찾을 수 없습니다."));
  }

  private MissionPost validatePost(Long postId) {
    return missionPostRepository.findById(postId)
        .orElseThrow(() -> new NoSuchElementException("게시글을 찾을 수 없습니다."));
  }

  private CursorPageResponse<MissionPostResponse> findByStatus(MissionPostQuery query, String status) {
    query = query.withStatus(status);

    CursorPageResponse<MissionPost> result = missionPostRepository.findAll(query);
    List<MissionPostResponse> content = result.content().stream()
        .map(missionPostMapper::toMissionPostResponse)
        .toList();

    return new CursorPageResponse<>(
        content,
        result.nextCursor(),
        result.nextIdAfter(),
        result.size(),
        result.hasNext()
    );
  }
}
