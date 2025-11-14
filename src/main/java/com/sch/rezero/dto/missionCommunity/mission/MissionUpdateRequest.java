package com.sch.rezero.dto.missionCommunity.mission;

import jakarta.validation.constraints.Future;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import java.time.LocalDateTime;

public record MissionUpdateRequest(
    @NotBlank(message = "미션 제목은 필수입니다.")
    String title,

    @NotBlank(message = "미션 설명은 필수입니다.")
    String description,

    @NotNull(message = "시작일을 입력해야 합니다.")
    LocalDateTime startDate,

    @NotNull(message = "종료일을 입력해야 합니다.")
    @Future(message = "종료일은 미래 시점이어야 합니다.")
    LocalDateTime endDate
) {

}
