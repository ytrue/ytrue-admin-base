package com.ytrue.mall.quartz.controller;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.ytrue.mall.common.annotation.SysLog;
import com.ytrue.mall.common.exeption.CustomValidateException;
import com.ytrue.mall.common.util.ResponseData;
import com.ytrue.mall.common.util.SearchParam;
import com.ytrue.mall.quartz.model.ScheduleJob;
import com.ytrue.mall.quartz.service.ScheduleJobService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;

/**
 * 定时任务
 *
 * @author ytrue
 */
@Slf4j
@RestController
@RequestMapping("/sys/schedule")
public class ScheduleJobController {

    @Autowired
    private ScheduleJobService scheduleJobService;

    /**
     * 定时任务列表
     */
    @PostMapping("/page")
    @PreAuthorize("@pms.hasPermission('sys:schedule:page')")
    public ResponseData<IPage<ScheduleJob>> page(@RequestBody SearchParam param) {
        return ResponseData.success(scheduleJobService.page(
                new Page<>(param.getPage(), param.getLimit()),
                param.<ScheduleJob>queryWrapper().orderByDesc("create_time")));
    }

    /**
     * 定时任务信息
     */
    @GetMapping("/info/{jobId}")
    @PreAuthorize("@pms.hasPermission('sys:schedule:info')")
    public ResponseData<ScheduleJob> info(@PathVariable("jobId") Long jobId) {
        ScheduleJob schedule = scheduleJobService.getById(jobId);
        return ResponseData.success(schedule);
    }

    /**
     * 保存定时任务
     */
    @SysLog("保存定时任务")
    @PostMapping
    @PreAuthorize("@pms.hasPermission('sys:schedule:save')")
    public ResponseData<String> save(@RequestBody @Valid ScheduleJob scheduleJob, BindingResult b) {
        int dbAlikeCount = scheduleJobService.count(new LambdaQueryWrapper<ScheduleJob>().eq(ScheduleJob::getBeanName, scheduleJob.getBeanName()).eq(ScheduleJob::getMethodName, scheduleJob.getMethodName()));
        if (dbAlikeCount > 0) {
            throw new CustomValidateException("定时任务已存在");
        }
        scheduleJobService.saveAndStart(scheduleJob);
        return ResponseData.success();
    }

    /**
     * 修改定时任务
     */
    @SysLog("修改定时任务")
    @PutMapping
    @PreAuthorize("@pms.hasPermission('sys:schedule:update')")
    public ResponseData<String> update(@RequestBody @Valid ScheduleJob scheduleJob, BindingResult b) {

        int dbAlikeCount = scheduleJobService.count(new LambdaQueryWrapper<ScheduleJob>().eq(ScheduleJob::getBeanName, scheduleJob.getBeanName()).eq(ScheduleJob::getMethodName, scheduleJob.getMethodName()).ne(ScheduleJob::getJobId, scheduleJob.getJobId()));
        if (dbAlikeCount > 0) {
            throw new CustomValidateException("定时任务已存在");
        }

        scheduleJobService.updateScheduleJob(scheduleJob);
        return ResponseData.success();
    }

    /**
     * 删除定时任务
     */
    @SysLog("删除定时任务")
    @DeleteMapping
    @PreAuthorize("@pms.hasPermission('sys:schedule:delete')")
    public ResponseData<String> delete(@RequestBody Long[] jobIds) {
        scheduleJobService.deleteBatch(jobIds);
        return ResponseData.success();
    }

    /**
     * 立即执行任务
     */
    @SysLog("立即执行任务")
    @PostMapping("/run")
    @PreAuthorize("@pms.hasPermission('sys:schedule:run')")
    public ResponseData<String> run(@RequestBody Long[] jobIds) {
        scheduleJobService.run(jobIds);
        return ResponseData.success();
    }

    /**
     * 暂停定时任务
     */
    @SysLog("暂停定时任务")
    @PostMapping("/pause")
    @PreAuthorize("@pms.hasPermission('sys:schedule:pause')")
    public ResponseData<String> pause(@RequestBody Long[] jobIds) {
        scheduleJobService.pause(jobIds);
        return ResponseData.success();
    }

    /**
     * 恢复定时任务
     */
    @SysLog("恢复定时任务")
    @PostMapping("/resume")
    @PreAuthorize("@pms.hasPermission('sys:schedule:resume')")
    public ResponseData<String> resume(@RequestBody Long[] jobIds) {
        scheduleJobService.resume(jobIds);
        return ResponseData.success();
    }

}
