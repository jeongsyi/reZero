package com.sch.rezero.repository.message;

import com.sch.rezero.entity.message.ChatRoom;
import com.sch.rezero.entity.user.User;
import java.util.List;
import java.util.Optional;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

public interface ChatRoomRepository extends JpaRepository<ChatRoom, Long> {

  @Query("""
           SELECT r FROM ChatRoom r
           WHERE (r.user1 = :userA AND r.user2 = :userB)
              OR (r.user1 = :userB AND r.user2 = :userA)
           """)
  Optional<ChatRoom> findExisting(User userA, User userB);

  List<ChatRoom> findAllByUser1OrUser2(User user1, User user2);

}
