package com.ytrue.mall.common.constant;

import lombok.Getter;

@Getter
public enum ResponseCode {

    //成功
    SUCCESS(200),

    //服务器错误
    SERVER_ERROR(500),

    //验证错误
    VALIDATION_FAILED(900),

    //参数验证错误
    PARARM_FAILED(1000);

    private final Integer code;

    ResponseCode(Integer code) {
        this.code = code;
    }
}
