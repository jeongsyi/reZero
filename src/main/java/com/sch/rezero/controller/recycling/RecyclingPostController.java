package com.sch.rezero.controller.recycling;

import com.sch.rezero.dto.recycling.recyclingPost.RecyclingPostCreateRequest;
import com.sch.rezero.dto.recycling.recyclingPost.RecyclingPostQuery;
import com.sch.rezero.dto.recycling.recyclingPost.RecyclingPostResponse;
import com.sch.rezero.dto.recycling.recyclingPost.RecyclingPostUpdateRequest;
import com.sch.rezero.dto.response.CursorPageResponse;
import com.sch.rezero.service.recycling.RecyclingPostService;
import jakarta.servlet.http.HttpSession;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;

@RequiredArgsConstructor
@RestController
@RequestMapping("/api/recycling-posts")
public class RecyclingPostController {
    private final RecyclingPostService recyclingPostService;

    @GetMapping
    public ResponseEntity<CursorPageResponse<RecyclingPostResponse>> findAll(RecyclingPostQuery query) {
        CursorPageResponse<RecyclingPostResponse> posts = recyclingPostService.findAll(query);
        return ResponseEntity.status(HttpStatus.OK).body(posts);
    }

    @GetMapping("/{postId}")
    public ResponseEntity<RecyclingPostResponse> findByPostId(@PathVariable Long postId) {
        RecyclingPostResponse post = recyclingPostService.find(postId);
        return ResponseEntity.status(HttpStatus.OK).body(post);
    }

    @PostMapping
    public ResponseEntity<RecyclingPostResponse> create(HttpSession session, @RequestPart @Valid RecyclingPostCreateRequest request,
                                                        @RequestPart List<MultipartFile> recyclingImage) {
        RecyclingPostResponse post = recyclingPostService.create(session, request, recyclingImage);
        return ResponseEntity.status(HttpStatus.CREATED).body(post);
    }

    @PatchMapping("/{postId}")
    public ResponseEntity<RecyclingPostResponse> update(HttpSession session, @PathVariable Long postId,
                                                        @RequestBody RecyclingPostUpdateRequest request) {
        RecyclingPostResponse post = recyclingPostService.update(session, postId, request);
        return ResponseEntity.status(HttpStatus.OK).body(post);
    }

    @DeleteMapping("/{postId}")
    public void delete(HttpSession session, @PathVariable Long postId) {
        recyclingPostService.delete(session, postId);
    }
}
