package com.sch.rezero.service.community;

import com.sch.rezero.dto.community.like.LikeResponse;
import com.sch.rezero.entity.community.CommunityPost;
import com.sch.rezero.entity.community.Like;
import com.sch.rezero.entity.user.User;
import com.sch.rezero.mapper.community.LikeMapper;
import com.sch.rezero.repository.community.CommunityPostRepository;
import com.sch.rezero.repository.community.LikeRepository;
import com.sch.rezero.repository.user.UserRepository;
import java.util.NoSuchElementException;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@RequiredArgsConstructor
public class LikeService {

  private final LikeRepository likeRepository;
  private final UserRepository userRepository;
  private final CommunityPostRepository communityPostRepository;
  private final LikeMapper likeMapper;

  @Transactional
  public LikeResponse createLike(Long userId, Long communityPostId) {
    User user = userRepository.findById(userId).orElseThrow(NoSuchElementException::new);
    CommunityPost communityPost = communityPostRepository.findById(communityPostId)
        .orElseThrow(NoSuchElementException::new);

    if (likeRepository.existsByUserAndCommunityPost(user, communityPost)) {
      throw new IllegalArgumentException("User and Community Post already exist");
    }

    Like like = new Like(communityPost, user);
    likeRepository.save(like);

    return likeMapper.toLikeResponse(like);
  }

  @Transactional
  public void delete(Long userId, Long communityPostId) {
    User user = userRepository.findById(userId).orElseThrow(NoSuchElementException::new);
    CommunityPost communityPost = communityPostRepository.findById(communityPostId)
        .orElseThrow(NoSuchElementException::new);

    likeRepository.deleteByUserAndCommunityPost(user, communityPost);
  }

}