package com.sch.rezero.service.missionCommunity;

import com.sch.rezero.dto.missionCommunity.like.LikeQuery;
import com.sch.rezero.dto.missionCommunity.like.MissionLikeResponse;
import com.sch.rezero.dto.response.CursorPageResponse;
import com.sch.rezero.entity.community.MissionPost;
import com.sch.rezero.entity.community.MissionPostLike;
import com.sch.rezero.entity.notification.Notification;
import com.sch.rezero.entity.user.User;
import com.sch.rezero.event.NotificationEvent;
import com.sch.rezero.mapper.missionCommunity.MissionLikeMapper;
import com.sch.rezero.repository.missionCommunity.MissionPostLikeRepository;
import com.sch.rezero.repository.missionCommunity.MissionPostRepository;
import com.sch.rezero.repository.user.UserRepository;
import jakarta.persistence.EntityNotFoundException;
import java.util.List;
import java.util.NoSuchElementException;
import lombok.RequiredArgsConstructor;
import org.springframework.context.ApplicationEventPublisher;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@RequiredArgsConstructor
public class MissionPostLikeService {

  private final MissionPostLikeRepository missionPostLikeRepository;
  private final MissionPostRepository missionPostRepository;
  private final UserRepository userRepository;
  private final MissionLikeMapper missionLikeMapper;
  private final ApplicationEventPublisher applicationEventPublisher;

  @Transactional
  public MissionLikeResponse like(Long postId, Long userId) {
    MissionPost missionPost = missionPostRepository.findById(postId)
        .orElseThrow(() -> new EntityNotFoundException("해당 게시글을 찾을 수 없습니다."));
    User user = userRepository.findById(userId)
        .orElseThrow(() -> new EntityNotFoundException("해당 유저를 찾을 수 없습니다."));

    if (missionPostLikeRepository.existsByMissionPostIdAndUserId(postId, userId)) {
      throw new IllegalStateException("이미 좋아요를 눌렀습니다.");
    }

    MissionPostLike like = new MissionPostLike(missionPost, user);
    missionPostLikeRepository.save(like);

    applicationEventPublisher.publishEvent(
        new NotificationEvent(
            this,
            missionPost.getUser().getId(),
            like.getUser().getId(),
            Notification.Type.LIKE,
            like.getUser().getId() + "님이 회원님의 게시글을 좋아합니다..️",
            missionPost.getId()
        )
    );

    return missionLikeMapper.toMissionLikeResponse(like);
  }

  @Transactional
  public void unlike(Long postId, Long userId) {
    MissionPostLike like = missionPostLikeRepository.findByMissionPostIdAndUserId(postId, userId)
        .orElseThrow(() -> new NoSuchElementException("좋아요 상태가 아닙니다."));
    missionPostLikeRepository.delete(like);
  }

  @Transactional(readOnly = true)
  public CursorPageResponse<MissionLikeResponse> findAll(Long userId, LikeQuery query) {
    CursorPageResponse<MissionPostLike> result = missionPostLikeRepository.findAllByUserId(userId, query);
    List<MissionLikeResponse> content = result.content().stream()
        .map(missionLikeMapper::toMissionLikeResponse).toList();

    return new CursorPageResponse<>(
        content,
        result.nextCursor(),
        result.nextIdAfter(),
        result.size(),
        result.hasNext()
    );
  }

  @Transactional(readOnly = true)
  public boolean isLiked(Long postId, Long userId) {
    return missionPostLikeRepository.existsByMissionPostIdAndUserId(postId, userId);
  }
}
