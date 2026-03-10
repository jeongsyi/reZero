package sch.rezero.config.exception;

import java.time.LocalDateTime;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;

@Slf4j
@RestControllerAdvice
public class ApiExceptionHandler {

    @ExceptionHandler(value = ApiException.class)
    public ResponseEntity<ErrorResponse> handleException(ApiException exception) {
        log.error("Exception occurred: {}, time: {}", exception.getMessage(), LocalDateTime.now());

        ErrorCode errorCode = exception.getErrorCode();
        ErrorResponse response = new ErrorResponse(errorCode.getCode(), errorCode.getDescription(),
            errorCode.getHttpStatus());

        return ResponseEntity.status(errorCode.getHttpStatus())
                             .body(response);
    }

}
