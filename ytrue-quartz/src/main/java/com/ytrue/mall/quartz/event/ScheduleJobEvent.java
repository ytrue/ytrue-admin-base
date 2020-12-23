package com.ytrue.mall.quartz.event;

import com.ytrue.mall.quartz.model.ScheduleJob;
import lombok.AllArgsConstructor;
import lombok.Getter;

/**
 * 定时任务事件
 */
@Getter
@AllArgsConstructor
public class ScheduleJobEvent {

    private final ScheduleJob scheduleJob;
}
