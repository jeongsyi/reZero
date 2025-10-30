package com.sch.rezero.repository.community;

import com.sch.rezero.dto.community.communityComment.CommunityCommentQuery;
import com.sch.rezero.dto.response.CursorPageResponse;
import com.sch.rezero.entity.community.CommunityComment;

import java.util.List;

public interface CommunityCommentQueryRepository {
    CursorPageResponse<CommunityComment> findAll(Long postId, CommunityCommentQuery communityCommentQuery);
    List<CommunityComment> findRepliesByParentIds(List<Long> parentIds);
}
