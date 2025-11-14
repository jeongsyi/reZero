package com.sch.rezero.dto.missionCommunity.ranking;

public record MissionRankingResponse(
    Long rank,
    Long userId,
    String userName,
    String profileUrl,
    Long totalLikes,
    Long participation,
    Double score
) {

}
