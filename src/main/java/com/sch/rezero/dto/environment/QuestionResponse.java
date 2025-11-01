package com.sch.rezero.dto.environment;

import java.util.List;

public record QuestionResponse(
    Long id,
    String question,
    int orderIndex,
    List<AnswerOption> options
) {
  public record AnswerOption(
      Long id,
      String answer,
      int score,
      int orderIndex
  ) {}

}
