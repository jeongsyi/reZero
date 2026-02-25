package sch.rezero.domain.complaint.dto.request;

public record ComplainCreateRequest(
    Long reported_id,
    String reason
) {

}