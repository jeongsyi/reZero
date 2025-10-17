package com.sch.rezero.repository.recycling.impl;

import com.querydsl.core.types.Order;
import com.querydsl.core.types.OrderSpecifier;
import com.querydsl.core.types.dsl.BooleanExpression;
import com.querydsl.core.types.dsl.Expressions;
import com.querydsl.core.types.dsl.NumberExpression;
import com.querydsl.jpa.JPAExpressions;
import com.querydsl.jpa.impl.JPAQueryFactory;
import com.sch.rezero.dto.recycling.recyclingPost.RecyclingPostQuery;
import com.sch.rezero.dto.response.CursorPageResponse;
import com.sch.rezero.entity.recycling.RecyclingPost;
import com.sch.rezero.repository.recycling.RecyclingPostQueryRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Repository;

import java.util.List;

import static com.sch.rezero.entity.recycling.QRecyclingPost.recyclingPost;
import static com.sch.rezero.entity.recycling.QScrap.scrap;

@Repository
@RequiredArgsConstructor
public class RecyclingPostQueryRepositoryImpl implements RecyclingPostQueryRepository {
    private final JPAQueryFactory queryFactory;

    @Override
    public CursorPageResponse<RecyclingPost> findAll(RecyclingPostQuery query) {
        //1. 데이터 조회
        List<RecyclingPost> posts = queryFactory.selectFrom(recyclingPost)
                .where(
                        query.title() != null ? recyclingPost.title.containsIgnoreCase(query.title()) : null,
                        query.description() != null ? recyclingPost.description.containsIgnoreCase(query.description()) : null,
                        query.userName() != null ? recyclingPost.user.name.contains(query.userName()) : null,
                        buildCursorCondition(query)
                )
                .orderBy(sortResolve(query.sortField(), query.sortDirection()))
                .limit(query.size() + 1)
                .fetch();

        //2. 다음 페이지 여부
        boolean hasNext = posts.size() > query.size();
        if (hasNext) {
            posts = posts.subList(0, query.size());
        }

        //3. 다음 커서 계산
        String nextCursor = null;
        Long nextIdAfter = null;

        if (!posts.isEmpty()) {
            RecyclingPost last = posts.get(posts.size() - 1);
            nextCursor = "scrap".equalsIgnoreCase(query.sortField())
                    ? String.valueOf(last.getScraps().size()) : last.getCreatedAt().toString();
            nextIdAfter = last.getId();
        }

        return new CursorPageResponse<>(posts, nextCursor, nextIdAfter, query.size(), hasNext);
    }

    private BooleanExpression buildCursorCondition(RecyclingPostQuery query) {
        if (query.cursor() == null || query.idAfter() == null) {
            return null;
        }

        boolean isDesc = "desc".equalsIgnoreCase(query.sortDirection());

        if ("scrap".equalsIgnoreCase(query.sortField())) {
            var expr = scrapCountExpr();
            Long cursorValue = Long.valueOf(query.cursor());
            return isDesc ? expr.lt(cursorValue).or(expr.eq(cursorValue).and(recyclingPost.id.lt(query.idAfter())))
                    : expr.gt(cursorValue).or(expr.eq(cursorValue).and(recyclingPost.id.gt(query.idAfter())));
        } else {
            return isDesc ? recyclingPost.id.lt(query.idAfter()) : recyclingPost.id.gt(query.idAfter());
        }
    }

    private OrderSpecifier<?>[] sortResolve(String sortField, String sortDirection) {
        Order order = "desc".equalsIgnoreCase(sortDirection) ? Order.DESC : Order.ASC;

        if ("scrap".equalsIgnoreCase(sortField)) {
            return new OrderSpecifier[]{new OrderSpecifier<>(order, scrapCountExpr()),
                    new OrderSpecifier<>(order, recyclingPost.id)};
        } else {
            return new OrderSpecifier[]{new OrderSpecifier<>(order, recyclingPost.id)};
        }
    }

    private NumberExpression<Long> scrapCountExpr() {
        return Expressions.asNumber(JPAExpressions
                .select(scrap.count())
                .from(scrap)
                .where(scrap.post.eq(recyclingPost)));
    }
}