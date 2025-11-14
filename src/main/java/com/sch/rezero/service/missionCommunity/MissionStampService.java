package com.sch.rezero.service.missionCommunity;

import com.sch.rezero.entity.community.Mission;
import com.sch.rezero.entity.community.MissionStamp;
import com.sch.rezero.entity.user.User;
import com.sch.rezero.repository.missionCommunity.MissionStampRepository;
import java.time.LocalDate;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@RequiredArgsConstructor
public class MissionStampService {
  private final MissionStampRepository missionStampRepository;

  @Transactional
  public void stampMission(Mission mission, User user) {
    LocalDate today = LocalDate.now();

    missionStampRepository.findByMissionIdAndUserIdAndStampDate(
        mission.getId(), user.getId(), today
    ).ifPresentOrElse(
        stamp -> {
          if (!stamp.isStamped()) stamp.stamp(); // 이미 있으면 찍기만
        },
        () -> {
          MissionStamp newStamp = new MissionStamp(mission, user, today, true);
          missionStampRepository.save(newStamp);
        }
    );
  }

  @Transactional
  public void unstampMission(Mission mission, User user) {
    LocalDate today = LocalDate.now();

    missionStampRepository.findByMissionIdAndUserIdAndStampDate(
        mission.getId(), user.getId(), today
    ).ifPresent(MissionStamp::unstamp);
  }

}
