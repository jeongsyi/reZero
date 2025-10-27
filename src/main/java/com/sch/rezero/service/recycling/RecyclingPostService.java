package com.sch.rezero.service.recycling;

import com.sch.rezero.config.S3Folder;
import com.sch.rezero.config.S3Service;
import com.sch.rezero.dto.recycling.recyclingPost.RecyclingPostCreateRequest;
import com.sch.rezero.dto.recycling.recyclingPost.RecyclingPostQuery;
import com.sch.rezero.dto.recycling.recyclingPost.RecyclingPostResponse;
import com.sch.rezero.dto.recycling.recyclingPost.RecyclingPostUpdateRequest;
import com.sch.rezero.dto.response.CursorPageResponse;
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
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
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
    private final S3Service s3Service;

    @Transactional
    public RecyclingPostResponse create(Long userId, RecyclingPostCreateRequest recyclingPostCreateRequest,
        MultipartFile thumbnailImage, List<MultipartFile> recyclingImage) throws IOException {
        User user = userRepository.findById(userId).orElseThrow(NoSuchElementException::new);
        if (!(user.getRole() == Role.ADMIN)) {
            throw new IllegalStateException("관리자만 재활용법 게시물 작성이 가능합니다.");
        }

        String thumbnailUrl = s3Service.uploadFile(thumbnailImage, S3Folder.RECYCLING_THUMBNAIL.getName());

        Category category = categoryRepository.findById(recyclingPostCreateRequest.categoryId()).orElseThrow(NoSuchElementException::new);

        RecyclingPost recyclingPost = new RecyclingPost(
                user,
                recyclingPostCreateRequest.title(),
                recyclingPostCreateRequest.description(),
                thumbnailUrl,
                category
        );

        recyclingPostRepository.save(recyclingPost);

        if (recyclingImage != null && !recyclingImage.isEmpty()) {
            for (MultipartFile imageFile : recyclingImage) {
                String imageUrl = s3Service.uploadFile(imageFile, S3Folder.RECYCLING.getName());
                RecyclingImage image = new RecyclingImage(recyclingPost, imageUrl);
                recyclingImageRepository.save(image);
                recyclingPost.addImage(image);
            }
        }
        return recyclingPostMapper.toRecyclingResponse(recyclingPost);
    }

    @Transactional(readOnly = true)
    public RecyclingPostResponse find(Long postId) {
        RecyclingPost recyclingPost = recyclingPostRepository.findById(postId).orElseThrow(NoSuchElementException::new);
        return recyclingPostMapper.toRecyclingResponse(recyclingPost);
    }

    @Transactional(readOnly = true)
    public CursorPageResponse<RecyclingPostResponse> findAll(RecyclingPostQuery query) {
        CursorPageResponse<RecyclingPost> result = recyclingPostRepository.findAll(query);
        List<RecyclingPostResponse> contents = result.content().stream().map(recyclingPostMapper::toRecyclingResponse).toList();

        return new CursorPageResponse<>(
                contents,
                result.nextCursor(),
                result.nextIdAfter(),
                result.size(),
                result.hasNext()
        );
    }

    @Transactional
    public RecyclingPostResponse update(Long userId, Long postId, RecyclingPostUpdateRequest recyclingPostUpdateRequest,
                                                            MultipartFile thumbnailImage, List<MultipartFile> recyclingImages)
        throws IOException {
        User user = userRepository.findById(userId).orElseThrow(NoSuchElementException::new);
        RecyclingPost recyclingPost = recyclingPostRepository.findById(postId).orElseThrow(NoSuchElementException::new);
        Category category;
        String imageUrl = recyclingPost.getThumbNailImageUrl();

        if (recyclingPostUpdateRequest.categoryId() != null) {
            category = categoryRepository.findById(recyclingPostUpdateRequest.categoryId()).orElseGet(() -> categoryRepository.findByCategory("기타"));
        } else {
            category = recyclingPostRepository.findById(postId).get().getCategory();
        }

        if (!user.getId().equals(recyclingPost.getUser().getId())) {
            throw new IllegalArgumentException("본인이 작성한 게시물만 수정 가능합니다");
        }

        // 썸네일 수정
        if (thumbnailImage != null && !thumbnailImage.isEmpty()) {
            if (imageUrl != null && !imageUrl.isEmpty()) {
                s3Service.deleteFile(imageUrl);
            }

            imageUrl = s3Service.uploadFile(thumbnailImage, S3Folder.RECYCLING_THUMBNAIL.getName());
        }

        // 본이미지 수정
        if (recyclingImages != null) {
            if (!recyclingPost.getImages().isEmpty()) {
                for (RecyclingImage oldImage : List.copyOf(recyclingPost.getImages())) {
                    if (oldImage.getImageUrl() != null && !oldImage.getImageUrl().isEmpty()) {
                        s3Service.deleteFile(oldImage.getImageUrl());
                    }
                    recyclingPost.deleteImage(oldImage);
                    recyclingImageRepository.delete(oldImage);
                }
            }

            if (!recyclingImages.isEmpty()) {
                for (MultipartFile imageFile : recyclingImages) {
                    if (imageFile != null && !imageFile.isEmpty()) {
                        String recyclingImageUrl = s3Service.uploadFile(imageFile, S3Folder.RECYCLING.getName());
                        RecyclingImage newImage = new RecyclingImage(recyclingPost, recyclingImageUrl);
                        recyclingImageRepository.save(newImage);
                        recyclingPost.addImage(newImage);
                    }
                }
            }
        }

        recyclingPost.update(recyclingPostUpdateRequest.title(),
                recyclingPostUpdateRequest.description(),
                imageUrl,
                category
        );
        return recyclingPostMapper.toRecyclingResponse(recyclingPost);
    }

    @Transactional
    public void delete(Long userId, Long postId) {
        User user = userRepository.findById(userId).orElseThrow(NoSuchElementException::new);
        RecyclingPost post = recyclingPostRepository.findById(postId).orElseThrow(NoSuchElementException::new);

        if (!user.getId().equals(post.getUser().getId())) {
            throw new IllegalArgumentException("본인이 작성한 게시물만 삭제 가능합니다");
        }

        if (post.getThumbNailImageUrl() != null && !post.getThumbNailImageUrl().isEmpty()) {
            s3Service.deleteFile(post.getThumbNailImageUrl());
        }

        if (post.getImages() != null && !post.getImages().isEmpty()) {
            for (RecyclingImage image : post.getImages()) {
                if (image.getImageUrl() != null && !image.getImageUrl().isEmpty()) {
                    s3Service.deleteFile(image.getImageUrl());
                }
            }
        }

        recyclingPostRepository.delete(post);
    }

//    @Transactional
//    public void deleteImage(HttpSession session, Long postId, Long imageId) {
//        User loginUser = (User) session.getAttribute("user");
//        User user = userRepository.findById(loginUser.getId()).orElseThrow(NoSuchElementException::new);
//        RecyclingPost post = recyclingPostRepository.findById(postId).orElseThrow(NoSuchElementException::new);
//        RecyclingImage image = recyclingImageRepository.findById(imageId).orElseThrow(NoSuchElementException::new);
//
//        if (!user.getId().equals(post.getUser().getId())) {
//            throw new IllegalArgumentException("게시물이 작성한 사용자만 이미지 삭제가 가능합니다");
//        }
//        if (!image.getPost().getId().equals(post.getId())) {
//            throw new IllegalArgumentException("해당 게시글의 이미지가 아닙니다.");
//        }
//
//        post.deleteImage(image);
//    }
}