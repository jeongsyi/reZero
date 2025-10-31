package com.sch.rezero.repository.user;

import com.sch.rezero.dto.response.CursorPageResponse;
import com.sch.rezero.dto.user.follow.FollowQuery;
import com.sch.rezero.entity.user.Follow;

public interface FollowQueryRepository {
    CursorPageResponse<Follow> findAllFollowerByUserId(Long userId, FollowQuery followQuery);

    CursorPageResponse<Follow> findAllFollowingByUserId(Long userId, FollowQuery followQuery);
}
