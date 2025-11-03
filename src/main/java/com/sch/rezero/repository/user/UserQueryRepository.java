package com.sch.rezero.repository.user;

import com.sch.rezero.dto.response.CursorPageResponse;
import com.sch.rezero.dto.user.profile.UserQuery;
import com.sch.rezero.entity.user.User;

public interface UserQueryRepository {
    CursorPageResponse<User> findAllUser(UserQuery query);
}
