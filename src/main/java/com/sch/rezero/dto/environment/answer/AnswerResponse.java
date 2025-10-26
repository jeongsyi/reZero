package com.sch.rezero.dto.environment.answer;

public record AnswerResponse(
    Long id,
    String answer,
    int score,
    String question
) {

}
