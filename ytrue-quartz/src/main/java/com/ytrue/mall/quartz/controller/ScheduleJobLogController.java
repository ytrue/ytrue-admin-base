package com.ytrue.mall.quartz.controller;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.ytrue.mall.common.util.ResponseData;
import com.ytrue.mall.common.util.SearchParam;
import com.ytrue.mall.quartz.model.ScheduleJobLog;
import com.ytrue.mall.quartz.service.ScheduleJobLogService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * 定时任务日志
 *
 * @author ytrue
 */
@RestController
@RequestMapping("/sys/scheduleLog")
public class ScheduleJobLogController {

    @Autowired
    private ScheduleJobLogService scheduleJobLogService;

    /**
     * 定时任务日志列表
     */
    @PostMapping("/page")
    @PreAuthorize("@pms.hasPermission('sys:schedule:log')")
    public ResponseData<IPage<ScheduleJobLog>> page(@RequestBody SearchParam param) {
        return ResponseData.success(
                scheduleJobLogService.page(
                        new Page<>(param.getPage(), param.getLimit()),
                        param.<ScheduleJobLog>queryWrapper().orderByDesc("create_time"))
        );
    }
}
