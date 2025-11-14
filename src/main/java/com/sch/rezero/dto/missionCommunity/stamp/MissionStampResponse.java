package com.sch.rezero.dto.missionCommunity.stamp;

import java.time.LocalDate;

public record MissionStampResponse(
    Long id,
    LocalDate stampDate,
    boolean stamped
) {

}
