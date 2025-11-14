package com.sch.rezero.mapper.missionCommunity;

import com.sch.rezero.dto.missionCommunity.mission.MissionResponse;
import com.sch.rezero.entity.community.Mission;
import org.mapstruct.Mapper;

@Mapper(componentModel = "spring")
public interface MissionMapper {

  MissionResponse toMissionResponse(Mission mission);

}
