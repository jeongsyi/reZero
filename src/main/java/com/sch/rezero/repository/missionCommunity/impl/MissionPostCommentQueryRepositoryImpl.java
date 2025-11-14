package com.sch.rezero.repository.missionCommunity.impl;

import static com.sch.rezero.entity.community.QMissionPostComment.missionPostComment;
import com.querydsl.core.types.Order;
import com.querydsl.core.types.OrderSpecifier;
import com.querydsl.core.types.dsl.BooleanExpression;
import com.querydsl.jpa.impl.JPAQueryFactory;
import com.sch.rezero.dto.missionCommunity.missionComment.MissionCommentQuery;
import com.sch.rezero.dto.response.CursorPageResponse;
import com.sch.rezero.entity.community.MissionPostComment;
import com.sch.rezero.repository.missionCommunity.MissionPostCommentQueryRepository;
import java.time.LocalDateTime;
import java.util.List;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Repository;

@Repository
@RequiredArgsConstructor
public class MissionPostCommentQueryRepositoryImpl implements MissionPostCommentQueryRepository {
  private final JPAQueryFactory queryFactory;

  @Override
  public CursorPageResponse<MissionPostComment> findAll(Long postId, MissionCommentQuery query) {
    List<MissionPostComment> comments = queryFactory.selectFrom(missionPostComment)
        .where(
            postId != null ? missionPostComment.missionPost.id.eq(postId) : null,
            missionPostComment.parent.isNull(),
            buildCursorCondition(query)
        )
        .orderBy(sortResolve(query.sortDirection()))
        .limit(query.size() + 1)
        .fetch();

    boolean hasNext = comments.size() > query.size();
    if (hasNext) {
      comments = comments.subList(0, query.size());
    }

    String nextCursor = null;
    Long nextIdAfter = null;

    if (!comments.isEmpty()) {
      MissionPostComment last = comments.get(comments.size() - 1);
      nextCursor = String.valueOf(last.getCreatedAt());
      nextIdAfter = last.getId();
    }

    return new CursorPageResponse<>(comments, nextCursor, nextIdAfter, query.size(), hasNext);
  }

  @Override
  public List<MissionPostComment> findRepliesByParentIds(List<Long> parentIds) {
    return queryFactory.selectFrom(missionPostComment)
        .where(missionPostComment.parent.id.in(parentIds))
        .fetch();
  }

  private BooleanExpression buildCursorCondition(MissionCommentQuery query) {
    if (query.cursor() == null || query.idAfter() == null) {
      return null;
    }

    boolean isDesc = "desc".equalsIgnoreCase(query.sortDirection());

    LocalDateTime cursorTime = LocalDateTime.parse(query.cursor());
    return isDesc ? missionPostComment.createdAt.lt(cursorTime).or(missionPostComment.createdAt.eq(cursorTime).and(missionPostComment.id.lt(query.idAfter())))
        : missionPostComment.createdAt.gt(cursorTime).or(missionPostComment.createdAt.eq(cursorTime).and(missionPostComment.id.gt(query.idAfter())));
  }

  private OrderSpecifier<?>[] sortResolve(String sortDirection) {
    Order order = ("desc").equalsIgnoreCase(sortDirection) ? Order.DESC : Order.ASC;

    return new OrderSpecifier[]{new OrderSpecifier<>(order, missionPostComment.createdAt), new OrderSpecifier<>(order, missionPostComment.id)};
  }
}
