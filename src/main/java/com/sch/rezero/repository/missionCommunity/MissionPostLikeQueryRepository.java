package com.sch.rezero.repository.missionCommunity;

import com.sch.rezero.dto.missionCommunity.like.LikeQuery;
import com.sch.rezero.dto.response.CursorPageResponse;
import com.sch.rezero.entity.community.MissionPostLike;

public interface MissionPostLikeQueryRepository {
  CursorPageResponse<MissionPostLike> findAllByUserId(Long userId, LikeQuery query);

}
