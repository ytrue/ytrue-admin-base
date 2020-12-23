package com.ytrue.mall.common.util;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import lombok.Data;

/**
 * 基础查询参数
 */
@Data
public class SearchParam {

    /**
     * 查询条件
     */
    private String condition;

    /**
     * 页码
     */
    private Long page = 1L;

    /**
     * 每页大小
     */
    private Long limit = 10L;


    public <T> QueryWrapper<T> queryWrapper() {
        return MybatisPlusSearchUtil.parseWhereSql(new QueryWrapper<>(), getCondition());
    }




}
