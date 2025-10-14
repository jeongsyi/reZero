package com.sch.rezero.config;

import com.sch.rezero.entity.user.User;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Component;

@Component
@RequiredArgsConstructor
public class UserContext {
    private final HttpSession session;

    public User getCurrentUser() {
        User user = (User) session.getAttribute("user");
        if (user == null) {
            throw new IllegalArgumentException("로그인된 사용자가 없습니다");
        }
        return user;
    }

    public Long getCurrentUserId() {
        return getCurrentUser().getId();
    }
}