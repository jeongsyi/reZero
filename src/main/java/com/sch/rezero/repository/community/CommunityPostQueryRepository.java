package com.sch.rezero.repository.community;

import com.sch.rezero.dto.community.communityPost.CommunityPostQuery;
import com.sch.rezero.dto.response.CursorPageResponse;
import com.sch.rezero.entity.community.CommunityPost;

public interface CommunityPostQueryRepository {
    CursorPageResponse<CommunityPost> findAll(CommunityPostQuery communityPostQuery);
}
