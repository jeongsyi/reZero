package com.sch.rezero.dto.missionCommunity.missionPost;

import jakarta.validation.constraints.Size;

public record MissionPostUpdateRequest(
    Long missionId,

    @Size(max = 100, message = "제목은 100자 이내로 입력해주세요.")
    String title,

    @Size(max = 2000, message = "설명은 최대 2000자까지 가능합니다.")
    String description
) {

}
