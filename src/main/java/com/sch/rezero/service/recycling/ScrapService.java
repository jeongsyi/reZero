package com.sch.rezero.service.recycling;

import com.sch.rezero.dto.recycling.scrap.ScrapQuery;
import com.sch.rezero.dto.recycling.scrap.ScrapResponse;
import com.sch.rezero.dto.response.CursorPageResponse;
import com.sch.rezero.entity.recycling.RecyclingPost;
import com.sch.rezero.entity.recycling.Scrap;
import com.sch.rezero.entity.user.User;
import com.sch.rezero.mapper.recycling.ScrapMapper;
import com.sch.rezero.repository.recycling.RecyclingPostRepository;
import com.sch.rezero.repository.recycling.ScrapRepository;
import com.sch.rezero.repository.user.UserRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.NoSuchElementException;

@Service
@RequiredArgsConstructor
public class ScrapService {
    private final ScrapRepository scrapRepository;
    private final RecyclingPostRepository recyclingPostRepository;
    private final UserRepository userRepository;
    private final ScrapMapper scrapMapper;

    @Transactional
    public ScrapResponse create(Long userId, Long postId) {
        RecyclingPost post = recyclingPostRepository.findById(postId).orElseThrow(NoSuchElementException::new);
        User user = userRepository.findById(userId).orElseThrow(NoSuchElementException::new);

        if (scrapRepository.existsByPostIdAndUserId(post.getId(), user.getId())) {
            throw new IllegalStateException("이미 존재하는 스크랩입니다");
        }

        Scrap scrap = new Scrap(post, user);
        return scrapMapper.toResponse(scrapRepository.save(scrap));
    }

    @Transactional(readOnly = true)
    public CursorPageResponse<ScrapResponse> findAllByUserId(ScrapQuery query) {
        CursorPageResponse<Scrap> result = scrapRepository.findAllByUserId(query);
        List<ScrapResponse> contents = result.content().stream().map(scrapMapper::toResponse).toList();

        return new CursorPageResponse<>(
                contents,
                result.nextCursor(),
                result.nextIdAfter(),
                result.size(),
                result.hasNext()
        );
    }

    @Transactional
    public void delete(Long userId, Long scrapId) {
        Scrap scrap = scrapRepository.findById(scrapId).orElseThrow(NoSuchElementException::new);
        User user = userRepository.findById(userId).orElseThrow(NoSuchElementException::new);

        if (!scrap.getUser().getId().equals(user.getId())) {
            throw new IllegalStateException("본인 스크랩만 삭제할 수 있습니다");
        }

        scrapRepository.delete(scrap);
    }
}