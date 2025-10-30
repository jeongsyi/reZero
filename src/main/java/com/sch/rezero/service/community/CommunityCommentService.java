package com.sch.rezero.service.community;

import com.sch.rezero.dto.community.communityComment.CommunityCommentCreateRequest;
import com.sch.rezero.dto.community.communityComment.CommunityCommentQuery;
import com.sch.rezero.dto.community.communityComment.CommunityCommentResponse;
import com.sch.rezero.dto.community.communityComment.CommunityCommentUpdateRequest;
import com.sch.rezero.dto.response.CursorPageResponse;
import com.sch.rezero.entity.community.CommunityComment;
import com.sch.rezero.entity.community.CommunityPost;
import com.sch.rezero.entity.user.User;
import com.sch.rezero.mapper.community.CommunityCommentMapper;
import com.sch.rezero.repository.community.CommunityCommentRepository;
import com.sch.rezero.repository.community.CommunityPostRepository;
import com.sch.rezero.repository.user.UserRepository;
import jakarta.persistence.EntityNotFoundException;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.NoSuchElementException;
import java.util.stream.Collectors;

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
        Long parentId = communityCommentCreateRequest.parentId();

        if (parentId != null) {
            parent = communityCommentRepository.findById(parentId)
                .orElseThrow(() -> new EntityNotFoundException("Parent comment not found"));
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

    @Transactional(readOnly = true)
    public CursorPageResponse<CommunityCommentResponse> findAll(Long postId, CommunityCommentQuery query) {
        if (!communityPostRepository.existsById(postId)) {
            throw new NoSuchElementException("해당 게시글을 찾을 수 없습니다");
        }

        CursorPageResponse<CommunityComment> parentComments = communityCommentRepository.findAll(postId, query);
        List<Long> parentIds = parentComments.content().stream()
                .map(CommunityComment::getId)
                .toList();

        List<CommunityComment> replies = communityCommentRepository.findRepliesByParentIds(parentIds);

        var groupedReplies = replies.stream()
                .collect(Collectors.groupingBy(c -> c.getParent().getId()));

        List<CommunityCommentResponse> responseList = parentComments.content().stream()
                .map(parent -> {
                    var parentDto = communityCommentMapper.toCommunityCommentResponse(parent);
                    var childDtos = groupedReplies.getOrDefault(parent.getId(), List.of()).stream()
                            .map(communityCommentMapper::toCommunityCommentResponse)
                            .toList();

                    return new CommunityCommentResponse(
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
    public CommunityCommentResponse update(Long id, Long userId,
                                           CommunityCommentUpdateRequest communityCommentUpdateRequest) {

        CommunityComment comment = communityCommentRepository.findById(id)
            .orElseThrow(EntityNotFoundException::new);

        if (!comment.getUser().getId().equals(userId)) {
            throw new EntityNotFoundException("요청한 ID와 실제 댓글 ID가 다릅니다.");
        }

        comment.update(communityCommentUpdateRequest.content());
        return communityCommentMapper.toCommunityCommentResponse(comment);
    }

    @Transactional
    public void delete(Long userId, Long communityCommentId) {
        CommunityComment communityComment = validateCommunityCommentId(communityCommentId);

        if (!communityComment.getUser().getId().equals(userId)) {
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