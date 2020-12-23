package com.ytrue.mall.common.exeption;

public class CustomTransactionalException extends RuntimeException {
    public CustomTransactionalException(String message) {
        super(message);
    }
}
