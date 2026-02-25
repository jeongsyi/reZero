package sch.rezero.domain.complaint.dto;

public record ComplainCreateRequest(
    Long reported_id,
    String reason
) {

}
