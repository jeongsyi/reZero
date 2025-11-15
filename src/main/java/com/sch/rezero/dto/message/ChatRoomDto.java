package com.sch.rezero.dto.message;

import java.time.LocalDateTime;
import java.util.List;
import lombok.Builder;
import lombok.Data;

public class ChatRoomDto {

  // 프로필 → DM 보내기 눌렀을 때 반환되는 정보
  @Data
  @Builder
  public static class RoomInfo {
    private Long roomId;
    private Long partnerId;
    private String partnerNickname;
    private String partnerProfileImageUrl;
  }

  // 메시지 관련 DTO
  @Data
  public static class MessageRequest {
    private Long roomId;
    private String content;
  }

  @Data
  @Builder
  public static class MessageResponse {
    private Long id;
    private Long roomId;
    private Long senderId;
    private String senderNickname;
    private String content;
    private Boolean isRead;
    private LocalDateTime readAt;
    private LocalDateTime createdAt;
  }

  // Cursor Pagination 공통 DTO
  @Data
  @Builder
  public static class CursorPageResponse<T> {
    private List<T> content;
    private Long nextCursor;
    private boolean hasNext;
  }

  @Data
  @Builder
  public static class ListItem {
    private Long roomId;
    private Long partnerId;
    private String partnerNickname;
    private String partnerProfileImageUrl;
    private String lastMessage;
  }
}