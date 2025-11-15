package com.sch.rezero.controller;

import com.sch.rezero.config.UserContext;
import com.sch.rezero.dto.message.ChatMessageDto;
import com.sch.rezero.dto.message.ChatRoomDto;
import com.sch.rezero.service.message.ChatService;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequiredArgsConstructor
@RequestMapping("/api/chat")
public class ChatController {

  private final ChatService chatService;
  private final UserContext userContext;

  /**
   * ✅ DM 버튼 → 방 생성 or 기존 방 반환
   */
  @GetMapping("/room")
  public ChatRoomDto.RoomInfo getOrCreateRoom(
      @RequestParam Long partnerId
  ) {
    return chatService.getOrCreateRoom(userContext.getCurrentUserId(), partnerId);
  }

  /**
   * ✅ 메시지 보내기
   */
  @PostMapping("/send")
  public ChatMessageDto.Response sendMessage(
      @RequestBody ChatMessageDto.Request req
  ) {
    return chatService.sendMessage(userContext.getCurrentUserId(), req);
  }

  /**
   * ✅ 메시지 조회 (cursor 기반)
   */
  @GetMapping("/messages")
  public List<ChatMessageDto.Response> getMessages(
      @RequestParam Long roomId,
      @RequestParam(required = false) Long cursor,
      @RequestParam(defaultValue = "30") int size
  ) {
    return chatService.getMessages(userContext.getCurrentUserId(), roomId, cursor, size);
  }

  @PatchMapping("/read")
  public void markMessagesRead(
      @RequestParam Long roomId
  ) {
    chatService.markMessagesAsRead(roomId, userContext.getCurrentUserId());
  }
}