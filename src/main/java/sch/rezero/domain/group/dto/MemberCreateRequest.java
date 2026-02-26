package sch.rezero.domain.group.dto;

public record MemberCreateRequest(
    Long userId,
    Long groupId
) {

}
