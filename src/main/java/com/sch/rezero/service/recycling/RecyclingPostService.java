package com.sch.rezero.service.recycling;

import com.sch.rezero.dto.recycling.recyclingPost.RecyclingPostCreateRequest;
import com.sch.rezero.dto.recycling.recyclingPost.RecyclingPostResponse;
import com.sch.rezero.dto.recycling.recyclingPost.RecyclingPostUpdateRequest;
import com.sch.rezero.entity.recycling.Category;
import com.sch.rezero.entity.recycling.RecyclingImage;
import com.sch.rezero.entity.recycling.RecyclingPost;
import com.sch.rezero.entity.user.Role;
import com.sch.rezero.entity.user.User;
import com.sch.rezero.mapper.recycling.RecyclingPostMapper;
import com.sch.rezero.repository.recycling.CategoryRepository;
import com.sch.rezero.repository.recycling.RecyclingImageRepository;
import com.sch.rezero.repository.recycling.RecyclingPostRepository;
import com.sch.rezero.repository.user.UserRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;
import java.util.NoSuchElementException;

@Service
@RequiredArgsConstructor
public class RecyclingPostService {
    private final RecyclingPostRepository recyclingPostRepository;
    private final UserRepository userRepository;
    private final CategoryRepository categoryRepository;
    private final RecyclingPostMapper recyclingPostMapper;
    private final RecyclingImageRepository recyclingImageRepository;

    @Transactional
    public RecyclingPostResponse create(Long userId, RecyclingPostCreateRequest recyclingPostCreateRequest, List<MultipartFile> recyclingImage) {
        User user = userRepository.findById(userId).orElseThrow(NoSuchElementException::new);
        if (!(user.getRole() == Role.ADMIN)) {
            throw new IllegalStateException("관리자만 재활용법 게시물 작성이 가능합니다.");
        }

        Category category = categoryRepository.findById(recyclingPostCreateRequest.categoryId()).orElseThrow(NoSuchElementException::new);

        RecyclingPost recyclingPost = new RecyclingPost(
                user,
                recyclingPostCreateRequest.title(),
                recyclingPostCreateRequest.description(),
                recyclingPostCreateRequest.thumbNailImage(),
                category
        );

        //이미지 저장 - 추후 구현
//        if (recyclingImage.isPresent()) {
//              RecyclingImage image = new RecyclingImage(recyclingPost, imageUrl)
//              recyclingPost.addImage(image);
//            }
//        }

        recyclingPostRepository.save(recyclingPost);
        return recyclingPostMapper.toRecyclingResponse(recyclingPost);
    }

    @Transactional(readOnly = true)
    public RecyclingPostResponse find(Long postId) {
        RecyclingPost recyclingPost = recyclingPostRepository.findById(postId).orElseThrow(NoSuchElementException::new);
        return recyclingPostMapper.toRecyclingResponse(recyclingPost);
    }

    @Transactional(readOnly = true)
    public List<RecyclingPostResponse> findAll() {
        return recyclingPostRepository.findAll().stream()
                .map(recyclingPostMapper::toRecyclingResponse)
                .toList();
    }

    @Transactional(readOnly = true)
    public List<RecyclingPostResponse> findAllByUserId(Long userId) {
        return recyclingPostRepository.findAllByUserId(userId).stream()
                .map(recyclingPostMapper::toRecyclingResponse)
                .toList();
    }

    @Transactional
    public RecyclingPostResponse update(Long userId, Long postId, RecyclingPostUpdateRequest recyclingPostUpdateRequest) {
        User user = userRepository.findById(userId).orElseThrow(NoSuchElementException::new);
        RecyclingPost recyclingPost = recyclingPostRepository.findById(postId).orElseThrow(NoSuchElementException::new);
        Category category = categoryRepository.findById(recyclingPostUpdateRequest.categoryId()).orElseThrow(NoSuchElementException::new);

        if (!user.getId().equals(recyclingPost.getUser().getId())) {
            throw new IllegalArgumentException("본인이 작성한 게시물만 수정 가능합니다");
        }

        recyclingPost.update(recyclingPostUpdateRequest.title(),
                recyclingPostUpdateRequest.description(),
                recyclingPostUpdateRequest.thumbNailImage(),
                category);
        return recyclingPostMapper.toRecyclingResponse(recyclingPost);
    }

    @Transactional
    public void delete(Long userId, Long postId) {
        User user = userRepository.findById(userId).orElseThrow(NoSuchElementException::new);
        RecyclingPost post = recyclingPostRepository.findById(postId).orElseThrow(NoSuchElementException::new);

        if (!user.getId().equals(post.getUser().getId())) {
            throw new IllegalArgumentException("본인이 작성한 게시물만 삭제 가능합니다");
        }

        recyclingPostRepository.delete(post);
    }

    @Transactional
    public void deleteImage(Long userId, Long postId, Long imageId) {
        User user = userRepository.findById(userId).orElseThrow(NoSuchElementException::new);
        RecyclingPost post = recyclingPostRepository.findById(postId).orElseThrow(NoSuchElementException::new);
        RecyclingImage image = recyclingImageRepository.findById(imageId).orElseThrow(NoSuchElementException::new);

        if (!user.getId().equals(post.getUser().getId())) {
            throw new IllegalArgumentException("게시물이 작성한 사용자만 이미지 삭제가 가능합니다");
        }
        if (!image.getPost().getId().equals(post.getId())) {
            throw new IllegalArgumentException("해당 게시글의 이미지가 아닙니다.");
        }

        post.deleteImage(image);
    }
}