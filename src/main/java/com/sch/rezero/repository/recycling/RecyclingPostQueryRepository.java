package com.sch.rezero.repository.recycling;

import com.sch.rezero.dto.recycling.recyclingPost.RecyclingPostQuery;
import com.sch.rezero.dto.response.CursorPageResponse;
import com.sch.rezero.entity.recycling.RecyclingPost;

public interface RecyclingPostQueryRepository {
    CursorPageResponse<RecyclingPost> findAll(RecyclingPostQuery recyclingPostQuery);
}
