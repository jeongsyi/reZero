package sch.rezero.domain.user.dto;

public record ProfileResponse(
    String loginId,
    String password,
    String name,
    String role,
    String profileUrl,
    int complaintCount
) {

}
