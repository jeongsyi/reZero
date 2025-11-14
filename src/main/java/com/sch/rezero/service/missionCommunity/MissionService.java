package com.sch.rezero.service.missionCommunity;

import com.sch.rezero.dto.missionCommunity.mission.MissionCreateRequest;
import com.sch.rezero.dto.missionCommunity.mission.MissionResponse;
import com.sch.rezero.dto.missionCommunity.mission.MissionUpdateRequest;
import com.sch.rezero.entity.community.Mission;
import com.sch.rezero.entity.user.Role;
import com.sch.rezero.entity.user.User;
import com.sch.rezero.mapper.missionCommunity.MissionMapper;
import com.sch.rezero.repository.missionCommunity.MissionRepository;
import com.sch.rezero.repository.user.UserRepository;
import java.util.List;
import java.util.NoSuchElementException;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@RequiredArgsConstructor
public class MissionService {

  private final MissionRepository missionRepository;
  private final UserRepository userRepository;
  private final MissionMapper missionMapper;

  @Transactional(readOnly = true)
  public MissionResponse getCurrentMission() {
    Mission mission = missionRepository.findActiveMission()
        .orElseThrow(() -> new IllegalStateException("현재 진행 중인 미션이 없습니다."));
    return missionMapper.toMissionResponse(mission);
  }

  @Transactional(readOnly = true)
  public List<MissionResponse> getPastMissions() {
    return missionRepository.findPastMissions().stream()
        .map(missionMapper::toMissionResponse)
        .toList();
  }

  @Transactional(readOnly = true)
  public MissionResponse getMissionById(Long missionId) {
    Mission mission = missionRepository.findById(missionId)
        .orElseThrow(() -> new IllegalArgumentException("해당 미션을 찾을 수 없습니다."));
    return missionMapper.toMissionResponse(mission);
  }

  @Transactional
  public MissionResponse createMission(Long userId, MissionCreateRequest request) {
    User user = userRepository.findById(userId)
        .orElseThrow(() -> new NoSuchElementException("사용자가 존재하지 않습니다."));

    if (user.getRole() == Role.USER) {
      throw new NoSuchElementException("사용자는 미션을 만들 수 없습니다.");
    }

    missionRepository.deactivateAllMissions();

    Mission mission = new Mission(
        request.title(),
        request.description(),
        request.startDate(),
        request.endDate(),
        true
    );

    Mission saved = missionRepository.save(mission);
    return missionMapper.toMissionResponse(saved);
  }

  @Transactional
  public MissionResponse updateCurrentMission(Long userId, MissionUpdateRequest request) {
    User user = userRepository.findById(userId)
        .orElseThrow(() -> new NoSuchElementException("사용자가 존재하지 않습니다."));

    if (user.getRole() == Role.USER) {
      throw new NoSuchElementException("사용자는 미션을 만들 수 없습니다.");
    }

    Mission mission = missionRepository.findActiveMission()
        .orElseThrow(() -> new IllegalStateException("현재 진행 중인 미션이 없습니다."));

    mission.update(
        request.title(),
        request.description(),
        request.startDate(),
        request.endDate()
    );
    return missionMapper.toMissionResponse(mission);
  }

  @Transactional(readOnly = true)
  public List<MissionResponse> getAllMissionsAdmin() {
    return missionRepository.findAllMissionsAdmin().stream()
        .map(missionMapper::toMissionResponse)
        .toList();
  }

  @Transactional
  public void deleteMission(Long userId, Long missionId) {
    User user = userRepository.findById(userId)
        .orElseThrow(() -> new NoSuchElementException("사용자가 존재하지 않습니다."));

    if (user.getRole() == Role.USER) {
      throw new IllegalStateException("관리자만 미션을 삭제할 수 있습니다.");
    }

    Mission mission = missionRepository.findById(missionId)
        .orElseThrow(() -> new NoSuchElementException("해당 미션을 찾을 수 없습니다."));

    missionRepository.delete(mission);
  }

}
