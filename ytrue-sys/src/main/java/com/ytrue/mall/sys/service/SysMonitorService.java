package com.ytrue.mall.sys.service;

import java.util.Map;

public interface SysMonitorService {
    /**
     * 查询数据分页
     *
     * @return Map<String, Object>
     */
    Map<String, Object> getServers();
}
