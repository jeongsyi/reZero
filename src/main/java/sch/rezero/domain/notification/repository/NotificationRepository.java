package sch.rezero.domain.notification.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import sch.rezero.domain.notification.entity.Notification;

@Repository
public interface NotificationRepository extends JpaRepository<Notification, Long> {

}
