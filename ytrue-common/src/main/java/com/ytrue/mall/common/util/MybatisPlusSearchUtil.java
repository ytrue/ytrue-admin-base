package com.ytrue.mall.common.util;

import cn.hutool.core.util.StrUtil;
import com.alibaba.fastjson.JSON;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.ytrue.mall.common.exeption.CustomParamException;
import lombok.Data;
import org.springframework.util.StringUtils;

import java.util.List;


/**
 * @author : ytrue
 * @description :mybatis plus 通用搜索<
 */
public class MybatisPlusSearchUtil {

    public static <T> QueryWrapper<T> parseWhereSql(QueryWrapper<T> queryWrapper, String conditionJson) {
        if (!StringUtils.isEmpty(conditionJson)) {
            List<ConditionDto> conditionDtoList = JSON.parseArray(conditionJson, ConditionDto.class);
            if (!conditionDtoList.isEmpty()) {
                for (ConditionDto conditionDto : conditionDtoList) {
                    // if (!StringUtils.isEmpty(conditionDto.getValue()) || null != conditionDto.getValue()) {
                    if (!StrUtil.hasBlank(conditionDto.getValue())) {
                        switch (conditionDto.getType()) {
                            case "eq":
                                queryWrapper.eq(conditionDto.getColumn(), conditionDto.getValue());
                                break;
                            case "ne":
                                queryWrapper.ne(conditionDto.getColumn(), conditionDto.getValue());
                                break;
                            case "like":
                                queryWrapper.like(conditionDto.getColumn(), conditionDto.getValue());
                                break;
                            case "leftLike":
                                queryWrapper.likeLeft(conditionDto.getColumn(), conditionDto.getValue());
                                break;
                            case "rightLike":
                                queryWrapper.likeRight(conditionDto.getColumn(), conditionDto.getValue());
                                break;
                            case "notLike":
                                queryWrapper.notLike(conditionDto.getColumn(), conditionDto.getValue());
                                break;
                            case "gt":
                                queryWrapper.gt(conditionDto.getColumn(), conditionDto.getValue());
                                break;
                            case "lt":
                                queryWrapper.lt(conditionDto.getColumn(), conditionDto.getValue());
                                break;
                            case "ge":
                                queryWrapper.ge(conditionDto.getColumn(), conditionDto.getValue());
                                break;
                            case "le":
                                queryWrapper.le(conditionDto.getColumn(), conditionDto.getValue());
                                break;
                            case "betweenDate":
                                String[] arr = conditionDto.getValue().split(",");
                                if (arr.length != 2) {
                                    throw new CustomParamException("日期参数不正确");
                                }
                                queryWrapper.apply(true, "DATE_FORMAT( " + conditionDto.getColumn() + ", '%Y-%m-%d %H:%i:%s' ) " +
                                        " >= DATE_FORMAT( '" + arr[0] + "', '%Y-%m-%d %H:%i:%s' )");
                                queryWrapper.apply(true, "DATE_FORMAT( " + conditionDto.getColumn() + ", '%Y-%m-%d %H:%i:%s' ) " +
                                        " <= DATE_FORMAT( '" + arr[1] + "', '%Y-%m-%d %H:%i:%s' )");
                                break;

                        }
                    }
                }
            }
        }
        return queryWrapper;
    }


    @Data
    private static class ConditionDto {
        private static final long serialVersionUID = -5099378457111419832L;
        /**
         * 数据库字段名
         */
        private String column;
        /**
         * 字段值
         */
        private String value;
        /**
         * 连接类型，如llike,equals,gt,ge,lt,le
         */
        private String type;
    }
}
