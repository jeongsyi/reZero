package com.sch.rezero.repository.user.impl;

import com.querydsl.core.types.Order;
import com.querydsl.core.types.OrderSpecifier;
import com.querydsl.core.types.dsl.BooleanExpression;
import com.querydsl.jpa.impl.JPAQueryFactory;
import com.sch.rezero.dto.response.CursorPageResponse;
import com.sch.rezero.dto.user.follow.FollowQuery;
import com.sch.rezero.entity.user.Follow;
import com.sch.rezero.repository.user.FollowQueryRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Repository;

import java.time.LocalDateTime;
import java.util.List;

import static com.sch.rezero.entity.user.QFollow.follow;

@Repository
@RequiredArgsConstructor
public class FollowQueryRepositoryImpl implements FollowQueryRepository {
    private final JPAQueryFactory queryFactory;

    // 사용자를 팔로우하는 팔로워 목록 조회
    @Override
    public CursorPageResponse<Follow> findAllFollowerByUserId(Long userId, FollowQuery query) {
        List<Follow> follows = queryFactory.selectFrom(follow)
                .where(
                        query.name() != null ? follow.follower.name.eq(query.name()) : null,
                        follow.following.id.eq(userId),
                        buildCursorCondition(query)
                )
                .orderBy(sortResolve(query.sortDirection()))
                .limit(query.size() + 1)
                .fetch();

        boolean hasNext = follows.size() > query.size();
        if (hasNext) {
            follows = follows.subList(0, query.size());
        }

        String nextCursor = null;
        Long nextIdAfter = null;

        if (!follows.isEmpty()) {
            Follow last = follows.get(follows.size() - 1);
            nextCursor = String.valueOf(last.getCreatedAt());
            nextIdAfter = last.getId();
        }

        return new CursorPageResponse<>(follows, nextCursor, nextIdAfter, query.size(), hasNext);
    }


    // 사용자가 팔로잉하는 팔로잉 목록 조회
    @Override
    public CursorPageResponse<Follow> findAllFollowingByUserId(Long userId, FollowQuery query) {
        List<Follow> follows = queryFactory.selectFrom(follow)
                .where(
                        query.name() != null ? follow.following.name.eq(query.name()) : null,
                        follow.follower.id.eq(userId),
                        buildCursorCondition(query)
                )
                .orderBy(sortResolve(query.sortDirection()))
                .limit(query.size() + 1)
                .fetch();

        boolean hasNext = follows.size() > query.size();
        if (hasNext) {
            follows = follows.subList(0, query.size());
        }

        String nextCursor = null;
        Long nextIdAfter = null;

        if (!follows.isEmpty()) {
            Follow last = follows.get(follows.size() - 1);
            nextCursor = String.valueOf(last.getCreatedAt());
            nextIdAfter = last.getId();
        }

        return new CursorPageResponse<>(follows, nextCursor, nextIdAfter, query.size(), hasNext);
    }

    private BooleanExpression buildCursorCondition(FollowQuery query) {
        if (query.cursor() == null || query.idAfter() == null) {
            return null;
        }

        boolean isDesc = "desc".equalsIgnoreCase(query.sortDirection());

        LocalDateTime cursorTime = LocalDateTime.parse(query.cursor());
        return isDesc ? follow.createdAt.lt(cursorTime).or(follow.createdAt.eq(cursorTime).and(follow.id.lt(query.idAfter())))
                : follow.createdAt.gt(cursorTime).or(follow.createdAt.eq(cursorTime).and(follow.id.gt(query.idAfter())));
    }


    private OrderSpecifier<?>[] sortResolve(String sortDirection) {
        Order order = "desc".equalsIgnoreCase(sortDirection) ? Order.DESC : Order.ASC;

        return new OrderSpecifier[]{new OrderSpecifier<>(order, follow.createdAt),
                new OrderSpecifier<>(order, follow.id)};
    }
}