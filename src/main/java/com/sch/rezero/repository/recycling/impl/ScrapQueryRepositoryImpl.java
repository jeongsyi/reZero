package com.sch.rezero.repository.recycling.impl;

import com.querydsl.core.types.Order;
import com.querydsl.core.types.OrderSpecifier;
import com.querydsl.core.types.dsl.BooleanExpression;
import com.querydsl.jpa.impl.JPAQueryFactory;
import com.sch.rezero.dto.recycling.scrap.ScrapQuery;
import com.sch.rezero.dto.response.CursorPageResponse;
import com.sch.rezero.entity.recycling.Scrap;
import com.sch.rezero.repository.recycling.ScrapQueryRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Repository;

import java.time.LocalDateTime;
import java.util.List;

import static com.sch.rezero.entity.recycling.QScrap.scrap;

@Repository
@RequiredArgsConstructor
public class ScrapQueryRepositoryImpl implements ScrapQueryRepository {
    private final JPAQueryFactory queryFactory;

    @Override
    public CursorPageResponse<Scrap> findAllByUserId(ScrapQuery query) {
        List<Scrap> scraps = queryFactory.selectFrom(scrap)
                .where(
                        query.userId() != null ? scrap.user.id.eq(query.userId()) : null,
                        buildCursorCondition(query)
                )
                .orderBy(sortResolve(query.sortDirection()))
                .limit(query.size() + 1)
                .fetch();

        boolean hasNext = scraps.size() > query.size();
        if (hasNext) {
            scraps = scraps.subList(0, query.size());
        }

        String nextCursor = null;
        Long nextIdAfter = null;

        if (!scraps.isEmpty()) {
            Scrap last = scraps.get(scraps.size() - 1);
            nextCursor = String.valueOf(last.getCreatedAt());
            nextIdAfter = last.getId();
        }

        return new CursorPageResponse<>(scraps, nextCursor, nextIdAfter, query.size(), hasNext);
    }

    private BooleanExpression buildCursorCondition(ScrapQuery query) {
        if (query.cursor() == null || query.idAfter() == null) {
            return null;
        }

        boolean isDesc = "desc".equalsIgnoreCase(query.sortDirection());

        LocalDateTime cursorTime = LocalDateTime.parse(query.cursor());
        return isDesc ? scrap.createdAt.lt(cursorTime).or(scrap.createdAt.eq(cursorTime).and(scrap.id.lt(query.idAfter())))
                : scrap.createdAt.gt(cursorTime).or(scrap.createdAt.eq(cursorTime).and(scrap.id.gt(query.idAfter())));
    }


    private OrderSpecifier<?>[] sortResolve(String sortDirection) {
        Order order = "desc".equalsIgnoreCase(sortDirection) ? Order.DESC : Order.ASC;

        return new OrderSpecifier[]{new OrderSpecifier<>(order, scrap.createdAt),
                new OrderSpecifier<>(order, scrap.id)};
    }
}