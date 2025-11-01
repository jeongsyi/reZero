package com.sch.rezero.dto.environment;

import java.util.List;

public record UserAnswerRequest(
    List<Long> answers
) {

}
