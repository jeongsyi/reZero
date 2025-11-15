package com.sch.rezero.repository.missionCommunity;

import com.sch.rezero.entity.community.MissionStamp;
import java.time.LocalDate;
import java.util.Optional;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface MissionStampRepository extends JpaRepository<MissionStamp, Long> {
  Optional<MissionStamp> findByMissionIdAndUserIdAndStampDate(Long missionId, Long userId, LocalDate stampDate);
  Optional<MissionStamp> findByUserIdAndStampDate(Long userId, LocalDate stampDate);
}
