package com.ytrue.mall.common.exeption;

/**
 * @author yangyi
 * @description：验证异常
 */
public class CustomValidateException extends RuntimeException {

    public CustomValidateException(String message) {
        super(message);
    }
}
