package sch.rezero.domain.user.dto;

public record ProfileUpdateRequest(
    String password,
    String name,
    String profileUrl
) {

}
