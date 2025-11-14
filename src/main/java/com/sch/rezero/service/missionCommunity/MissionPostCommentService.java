package com.sch.rezero.service.missionCommunity;

import com.sch.rezero.dto.missionCommunity.missionComment.MissionCommentCreateRequest;
import com.sch.rezero.dto.missionCommunity.missionComment.MissionCommentQuery;
import com.sch.rezero.dto.missionCommunity.missionComment.MissionCommentResponse;
import com.sch.rezero.dto.missionCommunity.missionComment.MissionCommentUpdateRequest;
import com.sch.rezero.dto.response.CursorPageResponse;
import com.sch.rezero.entity.community.CommunityComment;
import com.sch.rezero.entity.community.MissionPost;
import com.sch.rezero.entity.community.MissionPostComment;
import com.sch.rezero.entity.notification.Notification;
import com.sch.rezero.entity.user.User;
import com.sch.rezero.event.NotificationEvent;
import com.sch.rezero.mapper.missionCommunity.MissionPostCommentMapper;
import com.sch.rezero.repository.missionCommunity.MissionPostCommentRepository;
import com.sch.rezero.repository.missionCommunity.MissionPostRepository;
import com.sch.rezero.repository.user.UserRepository;
import jakarta.persistence.EntityNotFoundException;
import java.util.List;
import java.util.NoSuchElementException;
import java.util.stream.Collectors;
import lombok.RequiredArgsConstructor;
import org.springframework.context.ApplicationEventPublisher;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@RequiredArgsConstructor
public class MissionPostCommentService {

  private final MissionPostCommentRepository missionPostCommentRepository;
  private final MissionPostRepository missionPostRepository;
  private final UserRepository userRepository;
  private final MissionPostCommentMapper missionPostCommentMapper;
  private final ApplicationEventPublisher applicationEventPublisher;

  @Transactional
  public MissionCommentResponse create(Long userId, Long postId, MissionCommentCreateRequest request) {
    User user = validateUser(userId);
    MissionPost missionPost = validateMissionPost(postId);

    MissionPostComment parent = null;
    if (request.parentId() != null) {
      parent = missionPostCommentRepository.findById(request.parentId())
          .orElseThrow(() -> new EntityNotFoundException("부모 댓글을 찾을 수 없습니다."));
    }

    MissionPostComment comment = new MissionPostComment(
        missionPost,
        user,
        parent,
        request.content()
    );

    missionPostCommentRepository.save(comment);

    applicationEventPublisher.publishEvent(
        new NotificationEvent(
            this,
            missionPost.getUser().getId(),          // 수신자 = 게시글 작성자
            comment.getUser().getId(),              // 발신자 = 댓글 단 유저
            Notification.Type.COMMENT,
            comment.getUser().getName() + "님이 댓글을 남겼습니다.",
            missionPost.getId()
        )
    );

    return missionPostCommentMapper.toMissionCommentResponse(comment);
  }

  @Transactional(readOnly = true)
  public CursorPageResponse<MissionCommentResponse> findAll(Long postId, MissionCommentQuery query) {
    if (!missionPostRepository.existsById(postId)) {
      throw new NoSuchElementException("해당 미션 게시글이 존재하지 않습니다.");
    }

    CursorPageResponse<MissionPostComment> parentComments = missionPostCommentRepository.findAll(postId, query);
    List<Long> parentIds = parentComments.content().stream()
        .map(MissionPostComment::getId)
        .toList();

    List<MissionPostComment> replies = missionPostCommentRepository.findRepliesByParentIds(parentIds);

    var groupedReplies = replies.stream()
        .collect(Collectors.groupingBy(c -> c.getParent().getId()));

    List<MissionCommentResponse> responseList = parentComments.content().stream()
        .map(parent -> {
          var parentDto =  missionPostCommentMapper.toMissionCommentResponse(parent);
          var childDtos = groupedReplies.getOrDefault(parent.getId(), List.of()).stream()
              .map(missionPostCommentMapper::toMissionCommentResponse)
              .toList();

          return new MissionCommentResponse(
              parentDto.id(),
              parentDto.parentId(),
              parentDto.userId(),
              parentDto.userName(),
              parentDto.content(),
              parentDto.createdAt(),
              parentDto.updatedAt(),
              childDtos,
              parentDto.profileUrl()
          );
        })
        .toList();

    return new CursorPageResponse<>(
        responseList,
        parentComments.nextCursor(),
        parentComments.nextIdAfter(),
        parentComments.size(),
        parentComments.hasNext()
    );
  }

  @Transactional
  public MissionCommentResponse update(Long commentId, Long userId, MissionCommentUpdateRequest request) {
    MissionPostComment comment = missionPostCommentRepository.findById(commentId)
        .orElseThrow(() -> new EntityNotFoundException("댓글을 찾을 수 없습니다."));

    if (!comment.getUser().getId().equals(userId)) {
      throw new EntityNotFoundException("작성자만 댓글을 수정할 수 있습니다.");
    }

    comment.update(request.content());
    return missionPostCommentMapper.toMissionCommentResponse(comment);
  }

  @Transactional
  public void delete(Long commentId, Long userId) {
    MissionPostComment comment = missionPostCommentRepository.findById(commentId)
        .orElseThrow(() -> new EntityNotFoundException("댓글을 찾을 수 없습니다."));

    if (!comment.getUser().getId().equals(userId)) {
      throw new EntityNotFoundException("작성자만 댓글을 삭제할 수 있습니다.");
    }

    missionPostCommentRepository.delete(comment);
  }

  private User validateUser(Long userId) {
    return userRepository.findById(userId)
        .orElseThrow(() -> new NoSuchElementException("유저를 찾을 수 없습니다."));
  }

  private MissionPost validateMissionPost(Long postId) {
    return missionPostRepository.findById(postId)
        .orElseThrow(() -> new NoSuchElementException("미션 게시글을 찾을 수 없습니다."));
  }
}
