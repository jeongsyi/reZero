package com.sch.rezero.repository.missionCommunity.impl;

import static com.sch.rezero.entity.community.QLike.like;
import static com.sch.rezero.entity.community.QMissionPostLike.missionPostLike;

import com.querydsl.core.types.Order;
import com.querydsl.core.types.OrderSpecifier;
import com.querydsl.core.types.dsl.BooleanExpression;
import com.querydsl.jpa.impl.JPAQueryFactory;
import com.sch.rezero.dto.missionCommunity.like.LikeQuery;
import com.sch.rezero.dto.response.CursorPageResponse;
import com.sch.rezero.entity.community.MissionPostLike;
import com.sch.rezero.repository.missionCommunity.MissionPostLikeQueryRepository;
import java.time.LocalDateTime;
import java.util.List;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Repository;

@Repository
@RequiredArgsConstructor
public class MissionPostLikeQueryRepositoryImpl implements MissionPostLikeQueryRepository {

  private final JPAQueryFactory queryFactory;

  @Override
  public CursorPageResponse<MissionPostLike> findAllByUserId(Long userId, LikeQuery query) {
    List<MissionPostLike> likes = queryFactory.selectFrom(missionPostLike)
        .where(
            missionPostLike.user.id.eq(userId),
            buildCursorCondition(query)
        )
        .orderBy(sortResolve(query.sortDirection()))
        .limit(query.size() + 1)
        .fetch();

    boolean hasNext = likes.size() > query.size();
    if (hasNext) {
      likes = likes.subList(0, query.size());
    }

    String nextCursor = null;
    Long nextIdAfter = null;

    if (!likes.isEmpty()) {
      MissionPostLike last = likes.get(likes.size() - 1);
      nextCursor = String.valueOf(last.getCreatedAt());
      nextIdAfter = last.getId();
    }

    return new CursorPageResponse<>(likes, nextCursor, nextIdAfter, query.size(), hasNext);
  }

  private BooleanExpression buildCursorCondition(LikeQuery query) {
    if (query.cursor() == null || query.idAfter() == null) {
      return null;
    }

    boolean isDesc = "desc".equalsIgnoreCase(query.sortDirection());

    LocalDateTime cursorTime = LocalDateTime.parse(query.cursor());
    return isDesc ? missionPostLike.createdAt.lt(cursorTime).or(missionPostLike.createdAt.eq(cursorTime).and(missionPostLike.id.lt(query.idAfter())))
        : missionPostLike.createdAt.gt(cursorTime).or(missionPostLike.createdAt.eq(cursorTime).and(missionPostLike.id.gt(query.idAfter())));
  }


  private OrderSpecifier<?>[] sortResolve(String sortDirection) {
    Order order = ("desc").equalsIgnoreCase(sortDirection) ? Order.DESC : Order.ASC;

    return new OrderSpecifier[]{new OrderSpecifier<>(order, missionPostLike.createdAt),
        new OrderSpecifier<>(order, missionPostLike.id)};
  }

}
