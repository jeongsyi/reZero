package com.sch.rezero.dto.message;

import lombok.Builder;
import lombok.Data;

import java.time.LocalDateTime;

public class ChatMessageDto {

  /**
   * 메시지 전송 요청 DTO
   */
  @Data
  public static class Request {
    private Long roomId;     // 채팅방 ID
    private String content;  // 메시지 내용
  }

  /**
   * 메시지 응답 DTO
   */
  @Data
  @Builder
  public static class Response {
    private Long id;
    private Long roomId;
    private Long senderId;
    private String senderNickname;
    private String content;
    private Boolean isRead;
    private LocalDateTime readAt;
    private LocalDateTime createdAt;
  }
}