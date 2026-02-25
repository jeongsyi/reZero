package sch.rezero.domain.user.dto;

public record ProfileCreateRequest(
    String loginId,
    String password,
    String name,
    String profileUrl
) {

}
