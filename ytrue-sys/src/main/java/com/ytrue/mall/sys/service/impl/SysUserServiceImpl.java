package com.ytrue.mall.sys.service.impl;


import cn.hutool.core.collection.CollUtil;
import cn.hutool.core.date.DateUtil;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.ytrue.mall.common.exeption.CustomTransactionalException;
import com.ytrue.mall.sys.dao.SysUserMapper;
import com.ytrue.mall.sys.dao.SysUserRoleMapper;
import com.ytrue.mall.sys.model.SysUser;
import com.ytrue.mall.sys.model.SysUserRole;
import com.ytrue.mall.sys.service.SysUserService;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.transaction.interceptor.TransactionAspectSupport;

import java.util.Date;


/**
 * 系统用户
 *
 * @author lgh
 */
@Service("sysUserService")
@AllArgsConstructor
public class SysUserServiceImpl extends ServiceImpl<SysUserMapper, SysUser> implements SysUserService {

    private SysUserRoleMapper sysUserRoleMapper;

    private SysUserMapper sysUserMapper;

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void saveUserAndUserRole(SysUser user) {
        try {
            user.setCreateTime(DateUtil.date());
            save(user);
            if (CollUtil.isEmpty(user.getRoleIdList())) {
                return;
            }
            //保存用户与角色关系
            sysUserRoleMapper.insertUserAndUserRole(user.getUserId(), user.getRoleIdList());
        } catch (Exception e) {
            //手动回滚，处理try失效问题
            TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
            throw new CustomTransactionalException(e.getMessage());
        }
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void updateUserAndUserRole(SysUser user) {
        try {
            // 更新用户
            updateById(user);
            //先删除用户与角色关系
            sysUserRoleMapper.delete(new QueryWrapper<SysUserRole>().eq("user_id", user.getUserId()));

            if (CollUtil.isEmpty(user.getRoleIdList())) {
                return;
            }
            //保存用户与角色关系
            sysUserRoleMapper.insertUserAndUserRole(user.getUserId(), user.getRoleIdList());
        } catch (Exception e) {
            //手动回滚，处理try失效问题
            TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
            throw new CustomTransactionalException(e.getMessage());
        }
    }

    @Override
    public void updatePasswordByUserId(Long userId, String newPassword) {
        SysUser user = new SysUser();
        user.setPassword(newPassword);
        user.setUserId(userId);
        sysUserMapper.updateById(user);
    }
}
