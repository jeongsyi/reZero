package com.sch.rezero.mapper.missionCommunity;

import com.sch.rezero.dto.missionCommunity.stamp.MissionStampResponse;
import com.sch.rezero.entity.community.MissionStamp;
import java.util.List;
import org.mapstruct.Mapper;

@Mapper(componentModel = "spring")
public interface MissionStampMapper {

  MissionStampResponse toMissionStampResponse(MissionStamp missionStamp);

  List<MissionStampResponse> toMissionStampResponseList(List<MissionStamp> missionStamps);

}
