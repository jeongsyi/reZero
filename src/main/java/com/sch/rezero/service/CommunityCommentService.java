package com.sch.rezero.service;

import com.sch.rezero.dto.community.communityComment.CommunityCommentCreateRequest;
import com.sch.rezero.dto.community.communityComment.CommunityCommentResponse;
import com.sch.rezero.dto.community.communityComment.CommunityCommentUpdateRequest;
import com.sch.rezero.entity.community.CommunityComment;
import com.sch.rezero.entity.community.CommunityPost;
import com.sch.rezero.entity.user.User;
import com.sch.rezero.mapper.community.CommunityCommentMapper;
import com.sch.rezero.repository.community.CommunityCommentRepository;
import com.sch.rezero.repository.community.CommunityPostRepository;
import com.sch.rezero.repository.user.UserRepository;
import jakarta.persistence.EntityNotFoundException;
import java.util.NoSuchElementException;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@RequiredArgsConstructor
public class CommunityCommentService {

  private final CommunityCommentRepository communityCommentRepository;
  private final CommunityPostRepository communityPostRepository;
  private final UserRepository userRepository;
  private final CommunityCommentMapper communityCommentMapper;

  @Transactional
  public CommunityCommentResponse create(Long userId,
      Long communityPostId, CommunityCommentCreateRequest communityCommentCreateRequest) {

    User user = validateUserId(userId);

    CommunityPost communityPost = validateCommunityPostId(communityPostId);

    CommunityComment parent = null;
    if (communityCommentCreateRequest.parentId() != null) {
      parent = validateCommunityCommentId(communityCommentCreateRequest.parentId());
    }

    CommunityComment communityComment = new CommunityComment(
        user,
        communityPost,
        parent,
        communityCommentCreateRequest.content()
    );

    communityCommentRepository.save(communityComment);
    return communityCommentMapper.toCommunityCommentResponse(communityComment);
  }

  public CommunityCommentResponse update(Long userId, Long communityPostId, Long communityCommentId,
      CommunityCommentUpdateRequest communityCommentUpdateRequest) {

    CommunityPost communityPost = validateCommunityPostId(communityPostId);
    CommunityComment communityComment = validateCommunityCommentId(communityCommentId);

    if(!communityComment.getUser().getId().equals(userId)) {
      throw new EntityNotFoundException("요청한 ID와 실제 댓글 ID가 다릅니다.");
    }

    communityComment.update(communityCommentUpdateRequest.content());
    return communityCommentMapper.toCommunityCommentResponse(communityComment);
  }

  public void delete(Long userId, Long communityPostId, Long communityCommentId) {
    CommunityPost communityPost = validateCommunityPostId(communityPostId);
    CommunityComment communityComment = validateCommunityCommentId(communityCommentId);

    if(!communityComment.getUser().getId().equals(userId)) {
      throw new EntityNotFoundException("요청한 ID와 실제 댓글 ID가 다릅니다.");
    }

    communityCommentRepository.delete(communityComment);

  }

  private User validateUserId(Long userId) {
    return userRepository.findById(userId).orElseThrow(NoSuchElementException::new);
  }

  private CommunityPost validateCommunityPostId(Long communityPostId) {
    return communityPostRepository.findById(communityPostId)
        .orElseThrow(NoSuchElementException::new);
  }

  private CommunityComment validateCommunityCommentId(Long communityCommentId) {
    return communityCommentRepository.findById(communityCommentId)
        .orElseThrow(NoSuchElementException::new);
  }

}
