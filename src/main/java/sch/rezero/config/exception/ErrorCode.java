package sch.rezero.config.exception;

public interface ErrorCode {

    String getCode();

    String getDescription();

    Integer getHttpStatus();
}
