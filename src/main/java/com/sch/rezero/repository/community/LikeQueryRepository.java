package com.sch.rezero.repository.community;

import com.sch.rezero.dto.community.like.LikeQuery;
import com.sch.rezero.dto.response.CursorPageResponse;
import com.sch.rezero.entity.community.Like;

public interface LikeQueryRepository {
    CursorPageResponse<Like> findAllByUserId(LikeQuery likeQuery);
}
