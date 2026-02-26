package sch.rezero.domain.user.dto;

public record ProfileResponse(
    String loginId,
    String name,
    String role,
    String profileUrl
) {

}
