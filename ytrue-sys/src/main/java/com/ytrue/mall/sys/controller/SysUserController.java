package com.ytrue.mall.sys.controller;

import cn.hutool.core.convert.Convert;
import cn.hutool.core.util.StrUtil;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.google.common.collect.ImmutableMap;
import com.ytrue.mall.common.annotation.SysLog;
import com.ytrue.mall.common.exeption.CustomValidateException;
import com.ytrue.mall.common.util.ResponseData;
import com.ytrue.mall.common.util.SearchParam;
import com.ytrue.mall.security.jwt.JwtParseToken;
import com.ytrue.mall.sys.dto.UpdatePasswordDto;
import com.ytrue.mall.sys.model.SysMenu;
import com.ytrue.mall.sys.model.SysUser;
import com.ytrue.mall.sys.service.SysMenuService;
import com.ytrue.mall.sys.service.SysRoleService;
import com.ytrue.mall.sys.service.SysUserService;
import io.jsonwebtoken.Claims;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Objects;

/**
 * 系统用户
 *
 * @author ytrue
 */
@RestController
@RequestMapping("/sys/user")
@Slf4j
public class SysUserController {

    @Autowired
    private SysUserService sysUserService;

    @Autowired
    private SysRoleService sysRoleService;

    @Autowired
    private SysMenuService sysMenuService;

    @Autowired
    private JwtParseToken jwtParseToken;

    /**
     * 所有用户列表
     */
    @PostMapping("/page")
    @PreAuthorize("@pms.hasPermission('sys:user:page')")
    public ResponseData<IPage<SysUser>> page(@RequestBody SearchParam param) {
        Page<SysUser> sysUserPageResult = sysUserService.page(
                new Page<>(param.getPage(), param.getLimit()),
                param.<SysUser>queryWrapper().orderByDesc("create_time")
        );
        return ResponseData.success(sysUserPageResult);
    }


    /**
     * 用户信息
     */
    @GetMapping("/info/{userId}")
    @PreAuthorize("@pms.hasPermission('sys:user:info')")
    public ResponseData<SysUser> info(@PathVariable("userId") Long userId) {
        SysUser sysUser = sysUserService.getById(userId);
        //获取用户所属的角色列表
        List<Long> roleIdList = sysRoleService.listRoleIdByUserId(userId);
        sysUser.setRoleIdList(roleIdList);
        return ResponseData.success(sysUser);
    }

    /**
     * 保存用户
     */
    @SysLog("保存用户")
    @PostMapping
    @PreAuthorize("@pms.hasPermission('sys:user:save')")
    public ResponseData<String> save(
            @Valid @RequestBody SysUser user,
            BindingResult b
    ) {
        String username = user.getUsername();
        SysUser dbUser = sysUserService.getOne(new LambdaQueryWrapper<SysUser>()
                .eq(SysUser::getUsername, username));
        if (dbUser != null) {
            throw new CustomValidateException("该用户已存在");
        }
        BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
        user.setPassword(passwordEncoder.encode(user.getPassword()));
        sysUserService.saveUserAndUserRole(user);
        return ResponseData.success();
    }

    @SysLog("修改用户")
    @PutMapping
    @PreAuthorize("@pms.hasPermission('sys:user:update')")
    public ResponseData<String> update(
            @Valid @RequestBody SysUser user,
            BindingResult b
    ) {
        String password = user.getPassword();
        SysUser dbUserNameInfo = sysUserService.getOne(new QueryWrapper<SysUser>().eq("username", user.getUsername()));
        if (dbUserNameInfo != null && !Objects.equals(dbUserNameInfo.getUserId(), user.getUserId())) {
            return ResponseData.fail("该用户已存在");
        }
        if (StrUtil.isBlank(password)) {
            user.setPassword(null);
        } else {
            BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
            user.setPassword(passwordEncoder.encode(user.getPassword()));
        }
        sysUserService.updateUserAndUserRole(user);
        return ResponseData.success();
    }

    /**
     * 修改登录用户密码
     */
    @SysLog("修改密码")
    @PostMapping("/password")
    public ResponseData<String> password(@RequestBody @Valid UpdatePasswordDto param) {
        return ResponseData.success();
    }

    /**
     * 删除用户
     */
    @SysLog("删除用户")
    @DeleteMapping
    @PreAuthorize("@pms.hasPermission('sys:user:delete')")
    public ResponseData<String> delete(@RequestBody List<Long> userIds) {
        if (userIds.size() == 0) {
            return ResponseData.fail("请选择需要删除的用户");
        }
        if (userIds.contains(1L)) {
            return ResponseData.fail("系统管理员不能删除");
        }
        if (userIds.contains(Convert.toLong(jwtParseToken.getUserInfo().get("userId")))) {
            return ResponseData.fail("当前用户不能删除");
        }
        sysUserService.removeByIds(userIds);
        return ResponseData.success();
    }


    /**
     * 获得当前用户的就基本信息和路由信息
     *
     * @return
     */
    @RequestMapping("info")
    public ResponseData<Map<String, Object>> test01() {


        Claims userInfo = jwtParseToken.getUserInfo();
        HashMap<String, Object> map = new HashMap<>();
        map.put("avatar", userInfo.get("avatar"));
        map.put("name", userInfo.get("user_name"));
        return ResponseData.success(ImmutableMap.of(
                "info", map,
                "menus", sysMenuService.myRouter(Convert.toLong(userInfo.get("userId")))
        ));
    }
}
