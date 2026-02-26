package sch.rezero.domain.complaint.dto.response;

import java.time.LocalDateTime;

public record ComplainResponse(
    Long id,
    Long reporter_id,
    Long reported_id,
    String reason,
    String status,
    LocalDateTime createdAt,
    LocalDateTime updatedAt
) {

}