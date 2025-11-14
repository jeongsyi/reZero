package com.sch.rezero.service.missionCommunity;

import com.sch.rezero.dto.missionCommunity.ranking.MissionRankingResponse;
import com.sch.rezero.entity.community.MissionPost;
import com.sch.rezero.entity.community.MissionStamp;
import com.sch.rezero.entity.user.User;
import com.sch.rezero.repository.missionCommunity.MissionPostLikeRepository;
import com.sch.rezero.repository.missionCommunity.MissionPostRepository;
import com.sch.rezero.repository.missionCommunity.MissionStampRepository;
import java.util.Comparator;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.atomic.AtomicLong;
import lombok.Getter;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@RequiredArgsConstructor
public class MissionRankingService {

  private final MissionPostRepository missionPostRepository;
  private final MissionPostLikeRepository missionPostLikeRepository;
  private final MissionStampRepository missionStampRepository;

  /** 점수 계산 및 Top5 랭킹 반환 */
  @Transactional(readOnly = true)
  public List<MissionRankingResponse> calculateRankings() {

    Map<Long, RankingUserStat> userStats = new HashMap<>();

    // ✅ 1. 인증 승인 (10점)
    missionPostRepository.findAll().stream()
        .filter(p -> p.getStatus() == MissionPost.Status.APPROVED)
        .forEach(p -> userStats
            .computeIfAbsent(p.getUser().getId(), id -> new RankingUserStat(p.getUser()))
            .addParticipation(1)
            .addScore(10));

    // ✅ 2. 좋아요 (2점)
    missionPostLikeRepository.findAll()
        .forEach(like -> userStats
            .computeIfAbsent(like.getUser().getId(), id -> new RankingUserStat(like.getUser()))
            .addLike(1)
            .addScore(2));

    // ✅ 3. 스탬프 (5점)
    missionStampRepository.findAll().stream()
        .filter(MissionStamp::isStamped)
        .forEach(stamp -> userStats
            .computeIfAbsent(stamp.getUser().getId(), id -> new RankingUserStat(stamp.getUser()))
            .addScore(5));

    // ✅ 4. 점수 내림차순 + ID 오름차순 정렬
    AtomicLong rankCounter = new AtomicLong(1);
    return userStats.values().stream()
        .sorted(Comparator
            .comparingDouble(RankingUserStat::getScore).reversed()
            .thenComparing(stat -> stat.getUser().getId()))
        .limit(5)
        .map(stat -> new MissionRankingResponse(
            rankCounter.getAndIncrement(),
            stat.getUser().getId(),
            stat.getUser().getName(),
            stat.getUser().getProfileUrl(),
            stat.getTotalLikes(),
            stat.getParticipation(),
            stat.getScore()
        ))
        .toList();
  }

  /** 내부 계산용 클래스 */
  @Getter
  private static class RankingUserStat {
    private final User user;
    private long totalLikes = 0;
    private long participation = 0;
    private double score = 0;

    public RankingUserStat(User user) {
      this.user = user;
    }

    public RankingUserStat addLike(long count) {
      this.totalLikes += count;
      return this;
    }

    public RankingUserStat addParticipation(long count) {
      this.participation += count;
      return this;
    }

    public RankingUserStat addScore(double delta) {
      this.score += delta;
      return this;
    }
  }
}
