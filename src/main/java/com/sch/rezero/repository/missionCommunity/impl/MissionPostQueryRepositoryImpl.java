package com.sch.rezero.repository.missionCommunity.impl;

import static com.sch.rezero.entity.community.QMissionPost.missionPost;
import static com.sch.rezero.entity.community.QMissionPostLike.missionPostLike;

import com.querydsl.core.types.Order;
import com.querydsl.core.types.OrderSpecifier;
import com.querydsl.core.types.dsl.BooleanExpression;
import com.querydsl.core.types.dsl.Expressions;
import com.querydsl.core.types.dsl.NumberExpression;
import com.querydsl.jpa.JPAExpressions;
import com.querydsl.jpa.impl.JPAQueryFactory;
import com.sch.rezero.dto.missionCommunity.missionPost.MissionPostQuery;
import com.sch.rezero.dto.response.CursorPageResponse;
import com.sch.rezero.entity.community.MissionPost;
import com.sch.rezero.repository.missionCommunity.MissionPostQueryRepository;
import java.util.List;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Repository;

@Repository
@RequiredArgsConstructor
public class MissionPostQueryRepositoryImpl implements MissionPostQueryRepository {
  private final JPAQueryFactory queryFactory;

  @Override
  public CursorPageResponse<MissionPost> findAll(MissionPostQuery query) {

    BooleanExpression searchCondition = buildSearchCondition(query);
    BooleanExpression cursorCondition = buildCursorCondition(query);
    BooleanExpression statusCondition = buildStatusCondition(query);

    List<MissionPost> posts = queryFactory
        .selectFrom(missionPost)
        .where(searchCondition, statusCondition, cursorCondition)
        .orderBy(sortResolve(query.sortField(), query.sortDirection()))
        .limit(query.size() + 1)
        .fetch();

    boolean hasNext = posts.size() > query.size();
    if (hasNext) posts = posts.subList(0, query.size());

    String nextCursor = null;
    Long nextIdAfter = null;

    if (!posts.isEmpty()) {
      MissionPost last = posts.get(posts.size() - 1);
      nextCursor = "like".equalsIgnoreCase(query.sortField())
          ? String.valueOf(last.getLikes().size())
          : last.getCreatedAt().toString();
      nextIdAfter = last.getId();
    }

    return new CursorPageResponse<>(posts, nextCursor, nextIdAfter, query.size(), hasNext);
  }

  private BooleanExpression buildSearchCondition(MissionPostQuery query) {
    BooleanExpression titleCond = (query.title() != null && !query.title().isBlank())
        ? missionPost.title.containsIgnoreCase(query.title())
        : null;

    BooleanExpression descCond = (query.description() != null && !query.description().isBlank())
        ? missionPost.description.containsIgnoreCase(query.description())
        : null;

    BooleanExpression userCond = (query.userName() != null && !query.userName().isBlank())
        ? missionPost.user.name.containsIgnoreCase(query.userName())
        : null;

    if (titleCond != null || descCond != null || userCond != null) {
      return Expressions.anyOf(titleCond, descCond, userCond);
    }
    return null;
  }

  private BooleanExpression buildCursorCondition(MissionPostQuery query) {
    if (query.cursor() == null || query.idAfter() == null) return null;

    boolean isDesc = "desc".equalsIgnoreCase(query.sortDirection());

    if ("like".equalsIgnoreCase(query.sortField())) {
      var expr = likeCountExpr();
      long cursorValue = Long.parseLong(query.cursor());
      return isDesc
          ? expr.lt(cursorValue)
          .or(expr.eq(cursorValue).and(missionPost.id.lt(query.idAfter())))
          : expr.gt(cursorValue)
              .or(expr.eq(cursorValue).and(missionPost.id.gt(query.idAfter())));
    } else {
      return isDesc
          ? missionPost.id.lt(query.idAfter())
          : missionPost.id.gt(query.idAfter());
    }
  }

  private OrderSpecifier<?>[] sortResolve(String sortField, String sortDirection) {
    Order order = "desc".equalsIgnoreCase(sortDirection) ? Order.DESC : Order.ASC;

    if ("like".equalsIgnoreCase(sortField)) {
      return new OrderSpecifier[]{
          new OrderSpecifier<>(order, likeCountExpr()),
          new OrderSpecifier<>(order, missionPost.id)
      };
    } else {
      return new OrderSpecifier[]{
          new OrderSpecifier<>(order, missionPost.createdAt),
          new OrderSpecifier<>(order, missionPost.id)
      };
    }
  }

  private BooleanExpression buildStatusCondition(MissionPostQuery query) {
    if (query.status() == null) return null;

    try {
      return missionPost.status.eq(
          Enum.valueOf(MissionPost.Status.class, query.status().toUpperCase())
      );
    } catch (IllegalArgumentException e) {
      return null;
    }
  }

  private NumberExpression<Long> likeCountExpr() {
    return Expressions.asNumber(
        JPAExpressions
            .select(missionPostLike.count())
            .from(missionPostLike)
            .where(missionPostLike.missionPost.eq(missionPost))
    );
  }

}
