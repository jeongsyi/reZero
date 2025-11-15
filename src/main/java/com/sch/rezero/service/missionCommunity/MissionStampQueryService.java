package com.sch.rezero.service.missionCommunity;

import com.sch.rezero.dto.missionCommunity.stamp.MissionStampResponse;
import com.sch.rezero.entity.community.MissionStamp;
import com.sch.rezero.repository.missionCommunity.MissionStampRepository;
import java.time.DayOfWeek;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@RequiredArgsConstructor
public class MissionStampQueryService {
  private final MissionStampRepository missionStampRepository;

  /** 이번 주 월요일 ~ 일요일 7일치 도장판 반환 */
  @Transactional(readOnly = true)
  public List<MissionStampResponse> getWeekStamps(Long userId) {

    LocalDate today = LocalDate.now();
    DayOfWeek dow = today.getDayOfWeek();

    // 월요일을 기준으로 주 시작 계산
    LocalDate monday = today.minusDays(dow.getValue() - 1);

    List<MissionStampResponse> result = new ArrayList<>();

    for (int i = 0; i < 7; i++) {
      LocalDate date = monday.plusDays(i);

      MissionStamp stamp = missionStampRepository
          .findByUserIdAndStampDate(userId, date)
          .orElse(null);

      result.add(
          new MissionStampResponse(
              stamp != null ? stamp.getId() : null,
              date,
              stamp != null && stamp.isStamped()
          )
      );
    }

    return result;
  }

}
