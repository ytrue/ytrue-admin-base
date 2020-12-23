package com.ytrue.mall.common.aspect;

import com.ytrue.mall.common.constant.ResponseCode;
import com.ytrue.mall.common.util.ResponseData;
import lombok.extern.slf4j.Slf4j;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Pointcut;
import org.springframework.stereotype.Component;
import org.springframework.validation.BeanPropertyBindingResult;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;

import java.util.ArrayList;

/**
 * 校验切面类
 */
@Component
@Aspect
@Slf4j
public class ValidAspect {
    @Pointcut("execution(public * com.ytrue.mall.sys.controller.*.save(..))) && public * com.ytrue.mall.sys.controller.*.update(..)))")
    public void valid() {

    }

    /**
     * https://www.cnblogs.com/lingyejun/p/9941350.html SpringBoot 通过自定义注解实现AOP切面编程实例
     * 环绕上面的valid方法切入的controller包下面的所有类方法
     * 环绕通知,环绕增强，相当于MethodInterceptor
     *
     * @param pjp
     * @return
     */
    @Around("valid()")
    public Object around(ProceedingJoinPoint pjp) throws Throwable {

        Object[] objects = pjp.getArgs();
        for (Object object : objects) {
            if (object instanceof BeanPropertyBindingResult) {
                BeanPropertyBindingResult result = (BeanPropertyBindingResult) object;
                ResponseData<Object> error = hasError(result);
                if (null != error) {
                    return error;
                }
            }
        }
        // 执行源方法
        return pjp.proceed();
    }


    // 判断是否有异常
    private ResponseData<Object> hasError(BindingResult bindingResult) {
        if (bindingResult.hasErrors()) {
            ArrayList<String> errorList = new ArrayList<>();

            for (FieldError fieldError : bindingResult.getFieldErrors()) {
                errorList.add(fieldError.getDefaultMessage());
            }
            return ResponseData.fail(ResponseCode.PARARM_FAILED.getCode(), "validation failed", errorList);
        }
        return null;
    }
}
