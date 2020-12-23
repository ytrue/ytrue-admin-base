package com.ytrue.mall.sys.aspect;

import cn.hutool.core.date.DateUtil;
import cn.hutool.core.date.SystemClock;
import com.alibaba.fastjson.JSON;
import com.ytrue.mall.common.util.IPHelper;
import com.ytrue.mall.sys.model.SysLog;
import com.ytrue.mall.sys.service.SysLogService;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

/**
 * @author yangyi
 */
@Aspect
@Component
public class SysLogAspect {
    @Autowired
    private SysLogService sysLogService;

    @Around("@annotation(sysLog)")
    public Object around(ProceedingJoinPoint joinPoint, com.ytrue.mall.common.annotation.SysLog sysLog) throws Throwable {

        long beginTime = SystemClock.now();
        //执行方法
        Object result = joinPoint.proceed();
        //执行时长(毫秒)
        long time = SystemClock.now() - beginTime;


        SysLog sysLogEntity = new SysLog();
        if (sysLog != null) {
            //注解上的描述
            sysLogEntity.setOperation(sysLog.value());
        }

        //请求的方法名
        String className = joinPoint.getTarget().getClass().getName();
        String methodName = joinPoint.getSignature().getName();
        sysLogEntity.setMethod(className + "." + methodName + "()");

        //请求的参数
        Object[] args = joinPoint.getArgs();
        String params = JSON.toJSONString(args[0]);
        sysLogEntity.setParams(params);

        //设置IP地址
        sysLogEntity.setIp(IPHelper.getIpAddr());

        //用户名
        //String username = SecurityUtils.getSysUser().getUsername();
        String username = "临时用户名";
        sysLogEntity.setUsername(username);

        sysLogEntity.setTime(time);
        sysLogEntity.setCreateDate(DateUtil.date());
        //保存系统日志
        sysLogService.save(sysLogEntity);

        return result;
    }

}
