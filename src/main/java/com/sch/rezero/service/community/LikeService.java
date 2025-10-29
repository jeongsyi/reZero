package com.sch.rezero.service.community;

import com.sch.rezero.config.UserContext;
import com.sch.rezero.dto.community.like.LikeQuery;
import com.sch.rezero.dto.community.like.LikeResponse;
import com.sch.rezero.dto.response.CursorPageResponse;
import com.sch.rezero.entity.community.CommunityPost;
import com.sch.rezero.entity.community.Like;
import com.sch.rezero.entity.user.User;
import com.sch.rezero.mapper.community.LikeMapper;
import com.sch.rezero.repository.community.CommunityPostRepository;
import com.sch.rezero.repository.community.LikeRepository;
import com.sch.rezero.repository.user.UserRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.NoSuchElementException;

@Service
@RequiredArgsConstructor
public class LikeService {

    private final LikeRepository likeRepository;
    private final UserRepository userRepository;
    private final CommunityPostRepository communityPostRepository;
    private final LikeMapper likeMapper;

    @Transactional
    public LikeResponse create(Long userId, Long communityPostId) {
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

    @Transactional(readOnly = true)
    public CursorPageResponse<LikeResponse> findAllByUserId(Long userId, LikeQuery query) {
        CursorPageResponse<Like> result = likeRepository.findAllByUserId(userId, query);
        List<LikeResponse> contents = result.content().stream().map(likeMapper::toLikeResponse).toList();

        return new CursorPageResponse<>(
                contents,
                result.nextCursor(),
                result.nextIdAfter(),
                result.size(),
                result.hasNext()
        );
    }

    @Transactional
    public void deleteByPostId(Long userId, Long postId) {
        User user = userRepository.findById(userId).orElseThrow(NoSuchElementException::new);
        CommunityPost post = communityPostRepository.findById(postId)
            .orElseThrow(NoSuchElementException::new);

        Like like = likeRepository.findByUserAndCommunityPost(user, post)
            .orElseThrow(() -> new NoSuchElementException("Like not found"));

        likeRepository.delete(like);
    }

}