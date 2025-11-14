package com.sch.rezero.repository.missionCommunity;

import com.sch.rezero.dto.missionCommunity.missionPost.MissionPostQuery;
import com.sch.rezero.dto.response.CursorPageResponse;
import com.sch.rezero.entity.community.MissionPost;

public interface MissionPostQueryRepository {
  CursorPageResponse<MissionPost> findAll(MissionPostQuery query);

}
