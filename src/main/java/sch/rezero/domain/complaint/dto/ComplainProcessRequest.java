package sch.rezero.domain.complaint.dto;

import sch.rezero.domain.complaint.entity.Status;

public record ComplainProcessRequest(
    Status status
) {

}
