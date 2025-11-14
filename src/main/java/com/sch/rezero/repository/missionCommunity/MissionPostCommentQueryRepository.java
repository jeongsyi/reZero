package com.sch.rezero.repository.missionCommunity;

import com.sch.rezero.dto.community.communityComment.CommunityCommentQuery;
import com.sch.rezero.dto.missionCommunity.missionComment.MissionCommentQuery;
import com.sch.rezero.dto.response.CursorPageResponse;
import com.sch.rezero.entity.community.MissionPostComment;
import java.util.List;

public interface MissionPostCommentQueryRepository {
  CursorPageResponse<MissionPostComment> findAll(Long postId, MissionCommentQuery missionCommentQuery);
  List<MissionPostComment> findRepliesByParentIds(List<Long> parentIds);

}
