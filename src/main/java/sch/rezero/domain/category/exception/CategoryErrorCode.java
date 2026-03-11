package sch.rezero.domain.category.exception;

import lombok.AllArgsConstructor;
import lombok.Getter;
import org.springframework.http.HttpStatus;
import sch.rezero.config.exception.ErrorCode;

@Getter
@AllArgsConstructor
public enum CategoryErrorCode implements ErrorCode {
    DUPLICATE_CATEGORY_NAME("C001", "이미 존재하는 카테고리 이름입니다.", HttpStatus.BAD_REQUEST.value()),
    CATEGORY_NOT_FOUND("C002", "존재하지 않는 카테고리 아이디입니다.", HttpStatus.NOT_FOUND.value()),
    CATEGORY_DELETED("C003", "삭제된 카테고리입니다.", HttpStatus.GONE.value());

    private final String code;
    private final String description;
    private final Integer httpStatus;
}
