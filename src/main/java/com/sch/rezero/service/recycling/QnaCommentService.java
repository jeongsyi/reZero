package com.sch.rezero.service.recycling;

import com.sch.rezero.dto.recycling.qnaComment.QnaCommentCreateRequest;
import com.sch.rezero.dto.recycling.qnaComment.QnaCommentResponse;
import com.sch.rezero.dto.recycling.qnaComment.QnaCommentUpdateRequest;
import com.sch.rezero.entity.recycling.QnaComment;
import com.sch.rezero.entity.recycling.RecyclingPost;
import com.sch.rezero.entity.user.User;
import com.sch.rezero.mapper.recycling.QnaCommentMapper;
import com.sch.rezero.repository.recycling.QnaCommentRepository;
import com.sch.rezero.repository.recycling.RecyclingPostRepository;
import com.sch.rezero.repository.user.UserRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.NoSuchElementException;

@Service
@RequiredArgsConstructor
public class QnaCommentService {
    private final RecyclingPostRepository recyclingPostRepository;
    private final UserRepository userRepository;
    private final QnaCommentRepository qnaCommentRepository;
    private final QnaCommentMapper qnaCommentMapper;

    @Transactional
    public QnaCommentResponse create(Long userId, Long postId, QnaCommentCreateRequest qnaCommentCreateRequest) {
        User user = userRepository.findById(userId).orElseThrow(NoSuchElementException::new);
        RecyclingPost recyclingPost = recyclingPostRepository.findById(postId).orElseThrow(NoSuchElementException::new);
        QnaComment parent = qnaCommentRepository.findById(qnaCommentCreateRequest.parentId()).orElse(null);

        QnaComment qnaComment = new QnaComment(recyclingPost, user, parent, qnaCommentCreateRequest.content());

        qnaCommentRepository.save(qnaComment);
        return qnaCommentMapper.toQnaCommentResponse(qnaComment);
    }

    @Transactional(readOnly = true)
    public QnaCommentResponse find(Long commentId) {
        QnaComment qnaComment = qnaCommentRepository.findById(commentId).orElseThrow(NoSuchElementException::new);
        return qnaCommentMapper.toQnaCommentResponse(qnaComment);
    }

    @Transactional(readOnly = true)
    public List<QnaCommentResponse> findAllByPostId(Long postId) {
        return qnaCommentRepository.findAllByPostId(postId).stream().map(qnaCommentMapper::toQnaCommentResponse).toList();
    }

    @Transactional
    public QnaCommentResponse update(Long userId, Long postId, Long commentId, QnaCommentUpdateRequest qnaCommentUpdateRequest) {
        User user = userRepository.findById(userId).orElseThrow(NoSuchElementException::new);
        RecyclingPost recyclingPost = recyclingPostRepository.findById(postId).orElseThrow(NoSuchElementException::new);
        QnaComment qnaComment = qnaCommentRepository.findById(commentId).orElseThrow(NoSuchElementException::new);

        if (!user.getId().equals(recyclingPost.getUser().getId())) {
            throw new IllegalArgumentException("댓글을 작성한 사용자만 수정 가능합니다");
        }
        if (!qnaComment.getPost().equals(recyclingPost)) {
            throw new IllegalArgumentException("게시물에서 해당 댓글을 찾을 수 없습니다 ");
        }
        qnaComment.update(qnaCommentUpdateRequest.content());
        return qnaCommentMapper.toQnaCommentResponse(qnaComment);
    }

    @Transactional
    public void delete(Long userId, Long commentId) {
        User user = userRepository.findById(userId).orElseThrow(NoSuchElementException::new);
        QnaComment qnaComment = qnaCommentRepository.findById(commentId).orElseThrow(NoSuchElementException::new);

        if (!user.getId().equals(qnaComment.getUser().getId())) {
            throw new IllegalArgumentException("댓글을 작성한 사용자만 삭제 가능합니다");
        }

        qnaCommentRepository.delete(qnaComment);
    }
}