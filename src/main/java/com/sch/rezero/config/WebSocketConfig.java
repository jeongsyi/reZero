package com.sch.rezero.config;

import org.springframework.context.annotation.Configuration;
import org.springframework.messaging.simp.config.MessageBrokerRegistry;
import org.springframework.web.socket.config.annotation.EnableWebSocketMessageBroker;
import org.springframework.web.socket.config.annotation.StompEndpointRegistry;
import org.springframework.web.socket.config.annotation.WebSocketMessageBrokerConfigurer;

@Configuration
@EnableWebSocketMessageBroker   // 💡 이거 있어야 SimpMessagingTemplate 자동 등록됨!!
public class WebSocketConfig implements WebSocketMessageBrokerConfigurer {

  @Override
  public void configureMessageBroker(MessageBrokerRegistry config) {
    // 클라이언트가 구독할 수 있는 prefix
    config.enableSimpleBroker("/topic", "/queue");
    // 서버가 특정 사용자에게 전송할 때 사용하는 prefix
    config.setUserDestinationPrefix("/user");
    // 클라이언트가 서버로 보낼 때 사용하는 prefix
    config.setApplicationDestinationPrefixes("/app");
  }

  @Override
  public void registerStompEndpoints(StompEndpointRegistry registry) {
    registry.addEndpoint("/ws")      // ✅ 클라이언트 SockJS 연결 엔드포인트
        .setAllowedOriginPatterns("*")
        .withSockJS();
  }
}
