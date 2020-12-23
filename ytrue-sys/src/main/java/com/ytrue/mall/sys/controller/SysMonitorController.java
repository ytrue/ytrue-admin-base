package com.ytrue.mall.sys.controller;

import com.ytrue.mall.common.util.ResponseData;
import com.ytrue.mall.sys.service.SysMonitorService;
import lombok.RequiredArgsConstructor;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.Map;

/**
 * 服务监控管理
 */
@RestController
@RequiredArgsConstructor
@RequestMapping("/sys/monitor")
public class SysMonitorController {

    private final SysMonitorService serverService;

    @GetMapping
    @PreAuthorize("@pms.hasPermission('sys:monito:page' )")
    public ResponseData<Map<String, Object>> query() {
        return ResponseData.success(serverService.getServers());
    }
}
