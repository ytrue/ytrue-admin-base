package com.ytrue.mall.security.error;

import com.ytrue.mall.common.util.ResponseData;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.AuthenticationEntryPoint;
import org.springframework.stereotype.Component;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * 资源服务器-未登录访问权限控制
 *
 * @author：yangyi
 * @date：2020/5/16 17:58
 * @description：这里是认证权限入口 -> 即在未登录的情况下访问所有接口都会拦截到此（除了放行忽略接口）
 * <p>
 * 没有登录触发这个类
 */

@Component
@Slf4j
public class CustomAuthenticationEntryPoint implements AuthenticationEntryPoint {
    @Override
    public void commence(HttpServletRequest request, HttpServletResponse response, AuthenticationException e) {
        ResponseData.jsonOut(response,
                ResponseData.fail(903, "未登录"));
    }
}
