package com.sch.rezero.service.user;

import com.sch.rezero.dto.user.auth.LoginRequest;
import com.sch.rezero.dto.user.auth.LoginResponse;
import com.sch.rezero.entity.user.User;
import com.sch.rezero.mapper.user.UserMapper;
import com.sch.rezero.repository.user.UserRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@RequiredArgsConstructor
public class LoginService {

  private final UserRepository userRepository;
  private final UserMapper userMapper;

  @Transactional(readOnly = true)
  public User login(LoginRequest loginRequest) {

    String loginId = loginRequest.loginId();
    String password = loginRequest.password();

    User user = userRepository.findByLoginId(loginId)
        .orElseThrow(() -> new IllegalArgumentException("Invalid loginId"));

    if(!user.getPassword().equals(password)) {
      throw new IllegalArgumentException("Invalid password");
    }

    return user;
  }

}
