package com.ytrue.mall.quartz.service.impl;

import cn.hutool.core.date.DateUtil;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.ytrue.mall.quartz.config.ScheduleManager;
import com.ytrue.mall.quartz.dao.ScheduleJobMapper;
import com.ytrue.mall.quartz.enums.ScheduleStatus;
import com.ytrue.mall.quartz.model.ScheduleJob;
import com.ytrue.mall.quartz.service.ScheduleJobService;
import lombok.extern.slf4j.Slf4j;
import org.quartz.CronTrigger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.PostConstruct;
import java.util.Arrays;
import java.util.List;

@Service
@Slf4j
public class ScheduleJobServiceImpl extends ServiceImpl<ScheduleJobMapper, ScheduleJob> implements ScheduleJobService {

    @Autowired
    private ScheduleJobMapper scheduleJobMapper;
    @Autowired
    private ScheduleManager scheduleManager;

    /**
     * 项目启动时，初始化定时器
     */
    @PostConstruct
    public void init() {

        list().forEach(scheduleJob -> {
            CronTrigger trigger = scheduleManager.getCronTrigger(scheduleJob);
            // 如果定时任务不存在，则创建定时任务
            if (trigger == null) {
                scheduleManager.createScheduleJob(scheduleJob);
            } else if (ScheduleStatus.NORMAL.getType().equals(scheduleJob.getStatus())) {
                scheduleManager.resumeJob(scheduleJob);
            } else if (ScheduleStatus.PAUSE.getType().equals(scheduleJob.getStatus())) {
                scheduleManager.pauseJob(scheduleJob);
            }
        });
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void saveAndStart(ScheduleJob scheduleJob) {
        scheduleJob.setCreateTime(DateUtil.date());
        scheduleJob.setStatus(ScheduleStatus.NORMAL.getType());
        scheduleJobMapper.insert(scheduleJob);

        scheduleManager.createScheduleJob(scheduleJob);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void updateScheduleJob(ScheduleJob scheduleJob) {
        scheduleManager.updateScheduleJob(scheduleJob);
        scheduleJobMapper.updateById(scheduleJob);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void deleteBatch(Long[] jobIds) {
        List<Long> ids = Arrays.asList(jobIds);
        this.listByIds(ids).forEach(scheduleJob -> {
            scheduleManager.deleteScheduleJob(scheduleJob);
        });
        scheduleJobMapper.deleteBatchIds(ids);
    }

    @Override
    public int updateBatch(Long[] jobIds, int status) {
        return scheduleJobMapper.updateBatch(jobIds, status);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void run(Long[] jobIds) {
        for (Long jobId : jobIds) {
            scheduleManager.run(scheduleJobMapper.selectById(jobId));
        }
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void pause(Long[] jobIds) {
        this.listByIds(Arrays.asList(jobIds)).forEach(scheduleJob -> {
            scheduleManager.pauseJob(scheduleJob);
        });

        updateBatch(jobIds, ScheduleStatus.PAUSE.getType());
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void resume(Long[] jobIds) {
        this.listByIds(Arrays.asList(jobIds)).forEach(scheduleJob -> {
            scheduleManager.resumeJob(scheduleJob);
        });

        updateBatch(jobIds, ScheduleStatus.NORMAL.getType());
    }
}
