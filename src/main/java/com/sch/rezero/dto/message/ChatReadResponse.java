package com.sch.rezero.dto.message;

import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
public class ChatReadResponse {
  private Long roomId;
  private Long readerId;
}
