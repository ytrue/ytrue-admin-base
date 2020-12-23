package com.ytrue.mall.quartz.config;

import org.springframework.boot.autoconfigure.quartz.SchedulerFactoryBeanCustomizer;
import org.springframework.context.annotation.Configuration;
import org.springframework.scheduling.quartz.SchedulerFactoryBean;

/**
 *
 */
@Configuration
public class QuartzCustomizerConfig implements SchedulerFactoryBeanCustomizer {
    @Override
    public void customize(SchedulerFactoryBean schedulerFactoryBean) {
        //当调度器shutdown被调用时等待当前被调度的任务完成
        schedulerFactoryBean
                .setWaitForJobsToCompleteOnShutdown(true);
    }
}
