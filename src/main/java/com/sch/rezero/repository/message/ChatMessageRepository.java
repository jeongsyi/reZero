package com.sch.rezero.repository.message;

import com.sch.rezero.entity.message.ChatMessage;
import com.sch.rezero.entity.message.ChatRoom;
import java.util.List;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

public interface ChatMessageRepository extends JpaRepository<ChatMessage, Long> {
  // 최신 메시지 50개 (방 입장 시 최초 로딩)
  List<ChatMessage> findTop50ByChatRoomOrderByIdDesc(ChatRoom chatRoom);

  // cursor 기반 (id < cursor)
  List<ChatMessage> findTop50ByChatRoomAndIdLessThanOrderByIdDesc(ChatRoom chatRoom, Long cursor);

  List<ChatMessage> findByChatRoomAndSenderIdNotAndIsReadFalse(ChatRoom room, Long senderId);

  ChatMessage findTop1ByChatRoomOrderByIdDesc(ChatRoom chatRoom);
}
