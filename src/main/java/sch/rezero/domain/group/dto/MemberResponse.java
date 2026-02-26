package sch.rezero.domain.group.dto;

import java.time.LocalDateTime;

public record MemberResponse(
    Long id,
    Long userId,
    Long groupId,
    Boolean approved,
    LocalDateTime joinedAt
) {

}
