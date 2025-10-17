package com.sch.rezero.controller.recycling;

import com.sch.rezero.config.UserContext;
import com.sch.rezero.dto.recycling.qnaComment.QnaCommentCreateRequest;
import com.sch.rezero.dto.recycling.qnaComment.QnaCommentQuery;
import com.sch.rezero.dto.recycling.qnaComment.QnaCommentResponse;
import com.sch.rezero.dto.recycling.qnaComment.QnaCommentUpdateRequest;
import com.sch.rezero.dto.response.CursorPageResponse;
import com.sch.rezero.service.recycling.QnaCommentService;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RequiredArgsConstructor
@RestController
@RequestMapping("api/qna-comments")
public class QnaCommentController {
    private final QnaCommentService qnaCommentService;
    private final UserContext userContext;

    @GetMapping("/{postId}")
    public ResponseEntity<CursorPageResponse<QnaCommentResponse>> findAllByPostId(@PathVariable Long postId,
                                                                                  @ModelAttribute QnaCommentQuery query) {
        var comment = qnaCommentService.findAllByPostId(postId, query);
        return ResponseEntity.status(HttpStatus.OK).body(comment);
    }

    @PostMapping("/{postId}")
    public ResponseEntity<QnaCommentResponse> create(@PathVariable Long postId, @RequestBody @Valid QnaCommentCreateRequest request) {
        QnaCommentResponse comment = qnaCommentService.create(userContext.getCurrentUserId(), postId, request);
        return ResponseEntity.status(HttpStatus.CREATED).body(comment);
    }

    @PatchMapping("/{commentId}")
    public ResponseEntity<QnaCommentResponse> update(@PathVariable Long commentId, @RequestBody @Valid QnaCommentUpdateRequest request) {
        QnaCommentResponse comment = qnaCommentService.update(userContext.getCurrentUserId(), commentId, request);
        return ResponseEntity.status(HttpStatus.OK).body(comment);
    }

    @DeleteMapping("/{commentId}")
    public void delete(@PathVariable Long commentId) {
        qnaCommentService.delete(userContext.getCurrentUserId(), commentId);
    }
}