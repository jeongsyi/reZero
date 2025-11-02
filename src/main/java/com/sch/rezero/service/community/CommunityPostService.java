package com.sch.rezero.service.community;

import com.sch.rezero.config.S3Folder;
import com.sch.rezero.config.S3Service;
import com.sch.rezero.dto.community.communityPost.CommunityPostCreateRequest;
import com.sch.rezero.dto.community.communityPost.CommunityPostQuery;
import com.sch.rezero.dto.community.communityPost.CommunityPostResponse;
import com.sch.rezero.dto.community.communityPost.CommunityPostUpdateRequest;
import com.sch.rezero.dto.response.CursorPageResponse;
import com.sch.rezero.entity.community.CommunityImage;
import com.sch.rezero.entity.community.CommunityPost;
import com.sch.rezero.entity.user.User;
import com.sch.rezero.mapper.community.CommunityPostMapper;
import com.sch.rezero.repository.community.CommunityImageRepository;
import com.sch.rezero.repository.community.CommunityPostRepository;
import com.sch.rezero.repository.user.UserRepository;
import jakarta.persistence.EntityNotFoundException;
import java.io.IOException;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;
import java.util.NoSuchElementException;

@Service
@RequiredArgsConstructor
public class CommunityPostService {

    private final CommunityPostRepository communityPostRepository;
    private final UserRepository userRepository;
    private final CommunityImageRepository communityImageRepository;
    private final CommunityPostMapper communityPostMapper;
    private final S3Service s3Service;

    @Transactional
    public CommunityPostResponse create(Long userId, CommunityPostCreateRequest communityPostCreate,
                                        List<MultipartFile> communityPostImages)
        throws IOException {

        User user = ValidateUserId(userId);
        CommunityPost communityPost = new CommunityPost(
                user,
                communityPostCreate.title(),
                communityPostCreate.description()
        );

        communityPostRepository.save(communityPost);

        if (communityPostImages != null && !communityPostImages.isEmpty()) {
            for (MultipartFile imageFile : communityPostImages) {
                String imageUrl = s3Service.uploadFile(imageFile, S3Folder.COMMUNITY.getName());
                CommunityImage image = new CommunityImage(communityPost, imageUrl);
                communityImageRepository.save(image);
                communityPost.addImage(image);
            }
        }
        return communityPostMapper.toCommunityPostResponse(communityPost);
    }

    @Transactional(readOnly = true)
    public CommunityPostResponse findByPostId(Long communityPostId) {
        CommunityPost communityPost = validateCommunityPostId(communityPostId);

        return communityPostMapper.toCommunityPostResponse(communityPost);
    }

    @Transactional(readOnly = true)
    public CursorPageResponse<CommunityPostResponse> findAll(CommunityPostQuery query) {
        CursorPageResponse<CommunityPost> result = communityPostRepository.findAll(query);
        List<CommunityPostResponse> contents = result.content().stream().map(communityPostMapper::toCommunityPostResponse).toList();

        return new CursorPageResponse<>(
                contents,
                result.nextCursor(),
                result.nextIdAfter(),
                result.size(),
                result.hasNext()
        );
    }

    @Transactional(readOnly = true)
    public List<CommunityPostResponse> findByUser_Id(Long userId) {
        List<CommunityPost> posts = communityPostRepository.findByUser_Id(userId);
        return posts.stream().map(communityPostMapper::toCommunityPostResponse).toList();
    }

    @Transactional
    public <E> CommunityPostResponse update(Long userId, Long postId,
        CommunityPostUpdateRequest communityUpdateRequest, List<MultipartFile> communityPostImages)
        throws IOException {
        CommunityPost communityPost = validateCommunityPostId(postId);

        if (!communityPost.getUser().getId().equals(userId)) {
            throw new EntityNotFoundException("요청한 ID와 실제 ID가 다릅니다.");
        }

        if (communityPostImages != null) {
            if (!communityPost.getImages().isEmpty()) {
                for (CommunityImage oldImage : List.copyOf(communityPost.getImages())) {
                    if (oldImage.getImageUrl() != null && !oldImage.getImageUrl().isEmpty()) {
                        s3Service.deleteFile(oldImage.getImageUrl());
                    }
                    communityPost.deleteImage(oldImage);
                    communityImageRepository.delete(oldImage);
                }
            }

            if (!communityPostImages.isEmpty()) {
                for (MultipartFile imageFile : communityPostImages) {
                    if (imageFile != null && !imageFile.isEmpty()) {
                        String communityImageUrl = s3Service.uploadFile(imageFile, S3Folder.COMMUNITY.getName());
                        CommunityImage newImage = new CommunityImage(communityPost, communityImageUrl);
                        communityImageRepository.save(newImage);
                        communityPost.addImage(newImage);

                    }
                }
            }
        }


        communityPost.update(communityUpdateRequest.title(), communityUpdateRequest.description());
        return communityPostMapper.toCommunityPostResponse(communityPost);
    }

    @Transactional
    public void delete(Long userId, Long communityPostId) {
        CommunityPost communityPost = validateCommunityPostId(communityPostId);

        if (!communityPost.getUser().getId().equals(userId)) {
            throw new EntityNotFoundException("요청한 ID와 실제 ID가 다릅니다.");
        }

        if (communityPost.getImages() != null && !communityPost.getImages().isEmpty()) {
            for (CommunityImage image : communityPost.getImages()) {
                if (image.getImageUrl() != null && !image.getImageUrl().isEmpty()) {
                    s3Service.deleteFile(image.getImageUrl());
                }
            }
        }

        communityPostRepository.delete(communityPost);
    }

    @Transactional(readOnly = true)
    public CursorPageResponse<CommunityPostResponse> findFollowingFeed(Long userId, CommunityPostQuery query) {
        User user = ValidateUserId(userId);

        List<Long> followingIds = user.getFollowings().stream()
            .map(follow -> follow.getFollowing().getId())
            .toList();

        if (followingIds.isEmpty()) {
            return new CursorPageResponse<>(List.of(), null, null, query.size(), false);
        }

        // ✅ DB에서 바로 팔로잉 유저들의 게시글만 가져옴
        List<CommunityPost> posts = communityPostRepository.findByUserIds(followingIds);

        // ✅ MapStruct 변환
        List<CommunityPostResponse> contents = posts.stream()
            .map(communityPostMapper::toCommunityPostResponse)
            .toList();

        // ✅ 페이지 크기 제한
        boolean hasNext = contents.size() > query.size();
        List<CommunityPostResponse> paged = hasNext ? contents.subList(0, query.size()) : contents;

        String nextCursor = !paged.isEmpty() ? paged.get(paged.size() - 1).createdAt().toString() : null;
        Long nextIdAfter = !paged.isEmpty() ? paged.get(paged.size() - 1).id() : null;

        return new CursorPageResponse<>(
            paged,
            nextCursor,
            nextIdAfter,
            query.size(),
            hasNext
        );
    }



    private User ValidateUserId(Long userId) {
        return userRepository.findById(userId).orElseThrow(NoSuchElementException::new);
    }

    private CommunityPost validateCommunityPostId(Long communityPostId) {
        return communityPostRepository.findById(communityPostId)
                .orElseThrow(NoSuchElementException::new);
    }
}
