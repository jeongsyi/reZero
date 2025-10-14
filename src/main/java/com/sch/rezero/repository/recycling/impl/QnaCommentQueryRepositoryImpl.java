package com.sch.rezero.repository.recycling.impl;

import com.querydsl.core.types.Order;
import com.querydsl.core.types.OrderSpecifier;
import com.querydsl.core.types.dsl.BooleanExpression;
import com.querydsl.jpa.impl.JPAQueryFactory;
import com.sch.rezero.dto.recycling.qnaComment.QnaCommentQuery;
import com.sch.rezero.dto.response.CursorPageResponse;
import com.sch.rezero.entity.recycling.QnaComment;
import com.sch.rezero.repository.recycling.QnaCommentQueryRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Repository;

import java.time.LocalDateTime;
import java.util.List;

import static com.sch.rezero.entity.recycling.QQnaComment.qnaComment;

@Repository
@RequiredArgsConstructor
public class QnaCommentQueryRepositoryImpl implements QnaCommentQueryRepository {
    private final JPAQueryFactory queryFactory;

    @Override
    public CursorPageResponse<QnaComment> findAll(QnaCommentQuery query) {
        List<QnaComment> parentComments = queryFactory.selectFrom(qnaComment)
                .where(
                        query.postId() != null ? qnaComment.post.id.eq(query.postId()) : null,
                        qnaComment.parent.isNull(),
                        buildCursorCondition(query)
                )
                .orderBy(sortResolve(query.sortDirection()))
                .limit(query.size() + 1)
                .fetch();

        boolean hasNext = parentComments.size() > query.size();
        if (hasNext) {
            parentComments = parentComments.subList(0, query.size());
        }

        String nextCursor = null;
        Long nextIdAfter = null;

        if (!parentComments.isEmpty()) {
            QnaComment last = parentComments.get(parentComments.size() - 1);
            nextCursor = String.valueOf(last.getCreatedAt());
            nextIdAfter = last.getId();
        }

        return new CursorPageResponse<>(parentComments, nextCursor, nextIdAfter, query.size(), hasNext);
    }

    @Override
    public List<QnaComment> findRepliesByParentIds(List<Long> parentIds) {
        return queryFactory.selectFrom(qnaComment)
                .where(qnaComment.parent.id.in(parentIds))
                .fetch();
    }

    private BooleanExpression buildCursorCondition(QnaCommentQuery query) {
        if (query.cursor() == null || query.idAfter() == null) {
            return null;
        }

        boolean isDesc = "desc".equalsIgnoreCase(query.sortDirection());

        LocalDateTime cursorTime = LocalDateTime.parse(query.cursor());
        return isDesc ? qnaComment.createdAt.lt(cursorTime).or(qnaComment.createdAt.eq(cursorTime).and(qnaComment.id.lt(query.idAfter())))
                : qnaComment.createdAt.gt(cursorTime).or(qnaComment.createdAt.eq(cursorTime).and(qnaComment.id.gt(query.idAfter())));
    }

    private OrderSpecifier<?>[] sortResolve(String sortDirection) {
        Order order = "desc".equalsIgnoreCase(sortDirection) ? Order.DESC : Order.ASC;

        return new OrderSpecifier[]{new OrderSpecifier<>(order, qnaComment.createdAt),
                new OrderSpecifier<>(order, qnaComment.id)};
    }
}