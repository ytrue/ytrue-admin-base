package com.ytrue.mall.sys.controller;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.ytrue.mall.common.util.ResponseData;
import com.ytrue.mall.common.util.SearchParam;
import com.ytrue.mall.sys.model.SysLog;
import com.ytrue.mall.sys.service.SysLogService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * 系统日志
 *
 * @author ytrue
 */
@RestController
@RequestMapping("/sys/log")
public class SysLogController {

    @Autowired
    private SysLogService sysLogService;

    /**
     * 列表
     */
    @PostMapping("/page")
    @PreAuthorize("@pms.hasPermission('sys:log:page')")
    public ResponseData<IPage<SysLog>> page(@RequestBody SearchParam param) {

        Page<SysLog> sysLogPageResult = sysLogService.page(
                new Page<>(param.getPage(), param.getLimit()),
                param.<SysLog>queryWrapper().orderByDesc("create_date")
//
        );
        return ResponseData.success(sysLogPageResult);
    }
}
