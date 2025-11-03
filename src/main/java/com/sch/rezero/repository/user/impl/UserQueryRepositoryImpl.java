package com.sch.rezero.repository.user.impl;

import com.querydsl.core.types.Order;
import com.querydsl.core.types.OrderSpecifier;
import com.querydsl.core.types.dsl.BooleanExpression;
import com.querydsl.jpa.impl.JPAQueryFactory;
import com.sch.rezero.dto.response.CursorPageResponse;
import com.sch.rezero.dto.user.profile.UserQuery;
import com.sch.rezero.entity.user.User;
import com.sch.rezero.repository.user.UserQueryRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Repository;

import java.util.List;

import static com.sch.rezero.entity.user.QUser.user;

@Repository
@RequiredArgsConstructor
public class UserQueryRepositoryImpl implements UserQueryRepository {
    private final JPAQueryFactory queryFactory;

    // 사용자를 팔로우하는 팔로워 목록 조회
    @Override
    public CursorPageResponse<User> findAllUser(UserQuery query) {
        List<User> users = queryFactory.selectFrom(user)
                .where(
                        query.name() != null ? user.name.contains(query.name()) : null,
                        query.id() != null ? user.loginId.contains(query.id()) : null,
                        buildCursorCondition(query)
                )
                .orderBy(sortResolve(query.sortField(), query.sortDirection()))
                .limit(query.size() + 1)
                .fetch();

        boolean hasNext = users.size() > query.size();
        if (hasNext) {
            users = users.subList(0, query.size());
        }

        String nextCursor = null;
        Long nextIdAfter = null;

        if (!users.isEmpty()) {
            User last = users.get(users.size() - 1);
            nextCursor = "id".equalsIgnoreCase(query.sortField())
                    ? last.getLoginId() : last.getName();
            nextIdAfter = last.getId();
        }

        return new CursorPageResponse<>(users, nextCursor, nextIdAfter, query.size(), hasNext);
    }

    private BooleanExpression buildCursorCondition(UserQuery query) {
        if (query.cursor() == null) {
            return null;
        }

        boolean isDesc = "desc".equalsIgnoreCase(query.sortDirection());

        if ("id".equalsIgnoreCase(query.sortField())) {
            return isDesc
                    ? user.loginId.lt(query.cursor()).or(user.loginId.eq(query.cursor()).and(user.id.lt(query.idAfter())))
                    : user.loginId.gt(query.cursor()).or(user.loginId.eq(query.cursor()).and(user.id.gt(query.idAfter())));
        } else {
            return isDesc ? user.name.lt(query.cursor()).or(user.name.eq(query.cursor()).and(user.id.lt(query.idAfter())))
                    : user.name.gt(query.cursor()).or(user.name.eq(query.cursor()).and(user.id.gt(query.idAfter())));
        }
    }

    private OrderSpecifier<?>[] sortResolve(String sortField, String sortDirection) {
        Order order = "desc".equalsIgnoreCase(sortDirection) ? Order.DESC : Order.ASC;

        if ("id".equalsIgnoreCase(sortField)) {
            return new OrderSpecifier[]{new OrderSpecifier<>(order, user.loginId),
                    new OrderSpecifier<>(order, user.id)};
        } else {
            return new OrderSpecifier[]{new OrderSpecifier<>(order, user.name),
                    new OrderSpecifier<>(order, user.id)};
        }
    }
}