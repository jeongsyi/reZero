package sch.rezero.config.exception;

import lombok.AllArgsConstructor;
import lombok.Getter;
import org.springframework.http.HttpStatus;

@Getter
@AllArgsConstructor
public enum GlobalErrorCode implements ErrorCode {
    BAD_REQUEST("400", "잘못된 요청입니다", HttpStatus.BAD_REQUEST.value()),
    SERVER_ERROR("500", "서버 에러", HttpStatus.INTERNAL_SERVER_ERROR.value()),
    ;

    private final String code;
    private final String description;
    private final Integer httpStatus;
}
