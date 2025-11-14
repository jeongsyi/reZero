package com.sch.rezero.controller.missionCommunity;

import com.sch.rezero.config.UserContext;
import com.sch.rezero.dto.missionCommunity.mission.MissionCreateRequest;
import com.sch.rezero.dto.missionCommunity.mission.MissionResponse;
import com.sch.rezero.dto.missionCommunity.mission.MissionUpdateRequest;
import com.sch.rezero.service.missionCommunity.MissionService;
import jakarta.validation.Valid;
import java.util.List;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequiredArgsConstructor
@RequestMapping("/api/missions")
public class MissionController {

  private final MissionService missionService;
  private final UserContext userContext;

  @GetMapping("/current")
  public ResponseEntity<MissionResponse> getCurrentMission() {
    return ResponseEntity.ok(missionService.getCurrentMission());
  }

  @GetMapping("/past")
  public ResponseEntity<List<MissionResponse>> getPastMissions() {
    return ResponseEntity.ok(missionService.getPastMissions());
  }

  @GetMapping("/{missionId}")
  public ResponseEntity<MissionResponse> getMissionById(@PathVariable Long missionId) {
    return ResponseEntity.ok(missionService.getMissionById(missionId));
  }

  @PostMapping
  public ResponseEntity<MissionResponse> createMission(
      @Valid @RequestBody MissionCreateRequest request
  ) {
    Long userId = userContext.getCurrentUserId();
    return ResponseEntity.ok(missionService.createMission(userId, request));
  }

  @PutMapping("/current")
  public ResponseEntity<MissionResponse> updateCurrentMission(
      @Valid @RequestBody MissionUpdateRequest request
  ) {
    Long userId = userContext.getCurrentUserId();
    return ResponseEntity.ok(missionService.updateCurrentMission(userId, request));
  }

  @GetMapping("/admin/all")
  public ResponseEntity<List<MissionResponse>> getAllMissionsAdmin() {
    return ResponseEntity.ok(missionService.getAllMissionsAdmin());
  }

  @DeleteMapping("/{missionId}")
  public ResponseEntity<Void> deleteMission(@PathVariable Long missionId) {
    Long userId = userContext.getCurrentUserId();
    missionService.deleteMission(userId, missionId);
    return ResponseEntity.noContent().build();
  }

}
