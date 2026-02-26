package sch.rezero.domain.complaint.dto;

public record ComplainCreateRequest(
    Long reportedId,
    String reason
) {

}
