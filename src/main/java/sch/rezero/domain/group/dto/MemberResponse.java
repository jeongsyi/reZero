package sch.rezero.domain.group.dto;

import java.time.LocalDateTime;

public record MemberResponse(
    Long userId,
    Long groupId,
    Boolean approved,
    LocalDateTime joinedAt
) {

}
