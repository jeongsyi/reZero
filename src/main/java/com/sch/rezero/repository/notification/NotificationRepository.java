package com.sch.rezero.repository.notification;

import com.sch.rezero.entity.notification.Notification;
import com.sch.rezero.entity.user.User;
import java.util.List;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface NotificationRepository extends JpaRepository<Notification, Long> {
  List<Notification> findByUserOrderByCreatedAtDesc(User user);
}
