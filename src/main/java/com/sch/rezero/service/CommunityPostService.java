package com.sch.rezero.service;

import com.sch.rezero.dto.community.communityPost.CommunityPostCreateRequest;
import com.sch.rezero.dto.community.communityPost.CommunityPostResponse;
import com.sch.rezero.dto.community.communityPost.CommunityPostUpdateRequest;
import com.sch.rezero.entity.community.CommunityPost;
import com.sch.rezero.entity.user.User;
import com.sch.rezero.mapper.community.CommunityPostMapper;
import com.sch.rezero.repository.community.CommunityPostRepository;
import com.sch.rezero.repository.user.UserRepository;
import java.util.List;
import java.util.NoSuchElementException;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

@Service
@RequiredArgsConstructor
public class CommunityPostService {

  private final CommunityPostRepository communityPostRepository;
  private final UserRepository userRepository;
  private final CommunityPostMapper communityPostMapper;

  @Transactional
  public CommunityPostResponse create(Long userId, CommunityPostCreateRequest communityPostCreate,
      List<MultipartFile> communityPostImages) {

    User user = ValidateUserId(userId);
    CommunityPost communityPost = new CommunityPost(
        user,
        communityPostCreate.title(),
        communityPostCreate.description(),
        communityPostCreate.thumbNailImage()
    );

    communityPostRepository.save(communityPost);
    return communityPostMapper.toCommunityPostResponse(communityPost);
  }

  @Transactional(readOnly = true)
  public CommunityPostResponse findByPostId(Long communityPostId) {
    CommunityPost communityPost = validateCommunityPostId(communityPostId);

    return communityPostMapper.toCommunityPostResponse(communityPost);
  }

  @Transactional
  public CommunityPostResponse update(Long postId, CommunityPostUpdateRequest communityUpdateCreate) {
    CommunityPost communityPost = validateCommunityPostId(postId);

    communityPost.update(communityUpdateCreate.title(), communityUpdateCreate.description());
    return communityPostMapper.toCommunityPostResponse(communityPost);
  }

  @Transactional
  public void delete(Long communityPostId) {
    CommunityPost communityPost = validateCommunityPostId(communityPostId);
    communityPostRepository.delete(communityPost);
  }

  private User ValidateUserId(Long userId) {
    return userRepository.findById(userId).orElseThrow(NoSuchElementException::new);
  }

  private CommunityPost validateCommunityPostId(Long communityPostId) {
    return communityPostRepository.findById(communityPostId)
        .orElseThrow(NoSuchElementException::new);
  }
}
