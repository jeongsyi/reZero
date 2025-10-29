package com.sch.rezero.repository.community.impl;

import com.querydsl.core.types.Order;
import com.querydsl.core.types.OrderSpecifier;
import com.querydsl.core.types.dsl.BooleanExpression;
import com.querydsl.core.types.dsl.Expressions;
import com.querydsl.core.types.dsl.NumberExpression;
import com.querydsl.jpa.JPAExpressions;
import com.querydsl.jpa.impl.JPAQueryFactory;
import com.sch.rezero.dto.community.communityPost.CommunityPostQuery;
import com.sch.rezero.dto.response.CursorPageResponse;
import com.sch.rezero.entity.community.CommunityPost;
import com.sch.rezero.repository.community.CommunityPostQueryRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Repository;

import java.util.List;

import static com.sch.rezero.entity.community.QCommunityPost.communityPost;
import static com.sch.rezero.entity.community.QLike.like;

@Repository
@RequiredArgsConstructor
public class CommunityPostQueryRepositoryImpl implements CommunityPostQueryRepository {

    private final JPAQueryFactory queryFactory;

    @Override
    public CursorPageResponse<CommunityPost> findAll(CommunityPostQuery query) {

        BooleanExpression searchCondition = buildSearchCondition(query);

        BooleanExpression cursorCondition = buildCursorCondition(query);

        List<CommunityPost> posts = queryFactory
            .selectFrom(communityPost)
            .where(searchCondition, cursorCondition)
            .orderBy(sortResolve(query.sortField(), query.sortDirection()))
            .limit(query.size() + 1)
            .fetch();

        boolean hasNext = posts.size() > query.size();
        if (hasNext) posts = posts.subList(0, query.size());

        String nextCursor = null;
        Long nextIdAfter = null;

        if (!posts.isEmpty()) {
            CommunityPost last = posts.get(posts.size() - 1);
            nextCursor = "like".equalsIgnoreCase(query.sortField())
                ? String.valueOf(last.getLikes().size())
                : last.getCreatedAt().toString();
            nextIdAfter = last.getId();
        }

        return new CursorPageResponse<>(posts, nextCursor, nextIdAfter, query.size(), hasNext);
    }

    private BooleanExpression buildSearchCondition(CommunityPostQuery query) {
        BooleanExpression titleCond = (query.title() != null && !query.title().isBlank())
            ? communityPost.title.containsIgnoreCase(query.title())
            : null;

        BooleanExpression descCond = (query.description() != null && !query.description().isBlank())
            ? communityPost.description.containsIgnoreCase(query.description())
            : null;

        BooleanExpression userCond = (query.userName() != null && !query.userName().isBlank())
            ? communityPost.user.name.containsIgnoreCase(query.userName())
            : null;

        if (titleCond != null || descCond != null || userCond != null) {
            return Expressions.anyOf(titleCond, descCond, userCond);
        }
        return null;
    }

    private BooleanExpression buildCursorCondition(CommunityPostQuery query) {
        if (query.cursor() == null || query.idAfter() == null) return null;

        boolean isDesc = "desc".equalsIgnoreCase(query.sortDirection());

        if ("like".equalsIgnoreCase(query.sortField())) {
            var expr = likeCountExpr();
            long cursorValue = Long.parseLong(query.cursor());
            return isDesc
                ? expr.lt(cursorValue)
                .or(expr.eq(cursorValue).and(communityPost.id.lt(query.idAfter())))
                : expr.gt(cursorValue)
                    .or(expr.eq(cursorValue).and(communityPost.id.gt(query.idAfter())));
        } else {
            return isDesc
                ? communityPost.id.lt(query.idAfter())
                : communityPost.id.gt(query.idAfter());
        }
    }

    private OrderSpecifier<?>[] sortResolve(String sortField, String sortDirection) {
        Order order = "desc".equalsIgnoreCase(sortDirection) ? Order.DESC : Order.ASC;

        if ("like".equalsIgnoreCase(sortField)) {
            return new OrderSpecifier[]{
                new OrderSpecifier<>(order, likeCountExpr()),
                new OrderSpecifier<>(order, communityPost.id)
            };
        } else {
            return new OrderSpecifier[]{
                new OrderSpecifier<>(order, communityPost.createdAt),
                new OrderSpecifier<>(order, communityPost.id)
            };
        }
    }

    private NumberExpression<Long> likeCountExpr() {
        return Expressions.asNumber(
            JPAExpressions
                .select(like.count())
                .from(like)
                .where(like.communityPost.eq(communityPost))
        );
    }
}
