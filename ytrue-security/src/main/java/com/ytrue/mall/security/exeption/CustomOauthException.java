package com.ytrue.mall.security.exeption;

import com.fasterxml.jackson.databind.annotation.JsonSerialize;

import com.ytrue.mall.security.error.CustomOauthExceptionSerializer;
import org.springframework.security.oauth2.common.exceptions.OAuth2Exception;

/**
 * 认证服务器错误异常
 */
@JsonSerialize(using = CustomOauthExceptionSerializer.class)
public class CustomOauthException extends OAuth2Exception {
    public CustomOauthException(String msg) {
        super(msg);
    }
}

