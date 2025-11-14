package com.sch.rezero.repository.missionCommunity;

import com.sch.rezero.entity.community.Mission;
import java.util.List;
import java.util.Optional;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

@Repository
public interface MissionRepository extends JpaRepository<Mission, Long> {

  @Query("SELECT m FROM Mission m WHERE m.active = true")
  Optional<Mission> findActiveMission();

  @Query("SELECT m FROM Mission m WHERE m.active = false ORDER BY m.startDate DESC")
  List<Mission> findPastMissions();

  @Query("SELECT m FROM Mission m ORDER BY m.active DESC, m.startDate DESC")
  List<Mission> findAllMissionsAdmin();

  @Modifying(clearAutomatically = true)
  @Query("UPDATE Mission m SET m.active = false WHERE m.active = true")
  void deactivateAllMissions();
}
