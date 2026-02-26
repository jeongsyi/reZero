package sch.rezero.domain.complaint.dto;

import java.time.LocalDateTime;

public record ComplainResponse(
    Long id,
    Long reporterId,
    Long reportedId,
    String reason,
    String status,
    LocalDateTime created_at,
    LocalDateTime updated_at
) {

}
