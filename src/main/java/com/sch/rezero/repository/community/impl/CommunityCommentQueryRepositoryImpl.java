package com.sch.rezero.repository.community.impl;

import com.querydsl.core.types.Order;
import com.querydsl.core.types.OrderSpecifier;
import com.querydsl.core.types.dsl.BooleanExpression;
import com.querydsl.jpa.impl.JPAQueryFactory;
import com.sch.rezero.dto.community.communityComment.CommunityCommentQuery;
import com.sch.rezero.dto.response.CursorPageResponse;
import com.sch.rezero.entity.community.CommunityComment;
import com.sch.rezero.repository.community.CommunityCommentQueryRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Repository;

import java.time.LocalDateTime;
import java.util.List;

import static com.sch.rezero.entity.community.QCommunityComment.communityComment;

@Repository
@RequiredArgsConstructor
public class CommunityCommentQueryRepositoryImpl implements CommunityCommentQueryRepository {
    private final JPAQueryFactory queryFactory;

    @Override
    public CursorPageResponse<CommunityComment> findAll(CommunityCommentQuery query) {
        List<CommunityComment> comments = queryFactory.selectFrom(communityComment)
                .where(
                        query.postId() != null ? communityComment.communityPost.id.eq(query.postId()) : null,
                        communityComment.parent.isNull(),
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
            CommunityComment last = comments.get(comments.size() - 1);
            nextCursor = String.valueOf(last.getCreatedAt());
            nextIdAfter = last.getId();
        }

        return new CursorPageResponse<>(comments, nextCursor, nextIdAfter, query.size(), hasNext);
    }

    @Override
    public List<CommunityComment> findRepliesByParentIds(List<Long> parentIds) {
        return queryFactory.selectFrom(communityComment)
                .where(communityComment.parent.id.in(parentIds))
                .fetch();
    }

    private BooleanExpression buildCursorCondition(CommunityCommentQuery query) {
        if (query.cursor() == null || query.idAfter() == null) {
            return null;
        }

        boolean isDesc = "desc".equalsIgnoreCase(query.sortDirection());

        LocalDateTime cursorTime = LocalDateTime.parse(query.cursor());
        return isDesc ? communityComment.createdAt.lt(cursorTime).or(communityComment.createdAt.eq(cursorTime).and(communityComment.id.lt(query.idAfter())))
                : communityComment.createdAt.gt(cursorTime).or(communityComment.createdAt.eq(cursorTime).and(communityComment.id.gt(query.idAfter())));
    }

    private OrderSpecifier<?>[] sortResolve(String sortDirection) {
        Order order = ("desc").equalsIgnoreCase(sortDirection) ? Order.DESC : Order.ASC;

        return new OrderSpecifier[]{new OrderSpecifier<>(order, communityComment.createdAt), new OrderSpecifier<>(order, communityComment.id)};
    }
}