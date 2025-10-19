package com.sch.rezero.repository.community.impl;

import com.querydsl.core.types.Order;
import com.querydsl.core.types.OrderSpecifier;
import com.querydsl.core.types.dsl.BooleanExpression;
import com.querydsl.jpa.impl.JPAQueryFactory;
import com.sch.rezero.dto.community.like.LikeQuery;
import com.sch.rezero.dto.response.CursorPageResponse;
import com.sch.rezero.entity.community.Like;
import com.sch.rezero.repository.community.LikeQueryRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Repository;

import java.time.LocalDateTime;
import java.util.List;

import static com.sch.rezero.entity.community.QLike.like;

@Repository
@RequiredArgsConstructor
public class LikeQueryRepositoryImpl implements LikeQueryRepository {
    private final JPAQueryFactory queryFactory;

    @Override
    public CursorPageResponse<Like> findAllByUserId(Long userId, LikeQuery query) {
        List<Like> likes = queryFactory.selectFrom(like)
                .where(
                        like.user.id.eq(userId),
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
            Like last = likes.get(likes.size() - 1);
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
        return isDesc ? like.createdAt.lt(cursorTime).or(like.createdAt.eq(cursorTime).and(like.id.lt(query.idAfter())))
                : like.createdAt.gt(cursorTime).or(like.createdAt.eq(cursorTime).and(like.id.gt(query.idAfter())));
    }


    private OrderSpecifier<?>[] sortResolve(String sortDirection) {
        Order order = ("desc").equalsIgnoreCase(sortDirection) ? Order.DESC : Order.ASC;

        return new OrderSpecifier[]{new OrderSpecifier<>(order, like.createdAt),
                new OrderSpecifier<>(order, like.id)};
    }
}