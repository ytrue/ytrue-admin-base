package com.ytrue.mall.sys.controller;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.ytrue.mall.common.annotation.SysLog;
import com.ytrue.mall.common.util.ResponseData;
import com.ytrue.mall.common.util.SearchParam;
import com.ytrue.mall.sys.model.SysRole;
import com.ytrue.mall.sys.service.SysMenuService;
import com.ytrue.mall.sys.service.SysRoleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.List;

@RestController
@RequestMapping("/sys/role")
public class SysRoleController {

    @Autowired
    private SysRoleService sysRoleService;

    @Autowired
    private SysMenuService sysMenuService;

    /**
     * 角色列表
     */
    @PostMapping("/page")
    @PreAuthorize("@pms.hasPermission('sys:role:page')")
    public ResponseData<IPage<SysRole>> page(@RequestBody SearchParam param) {
        Page<SysRole> sysRolePageResult = sysRoleService.page(
                new Page<>(param.getPage(), param.getLimit()),
                param.<SysRole>queryWrapper().orderByDesc("create_time")
        );
        return ResponseData.success(sysRolePageResult);
    }

    /**
     * 角色列表
     */
    @GetMapping("/list")
    @PreAuthorize("@pms.hasPermission('sys:role:list')")
    public ResponseData<List<SysRole>> list() {
        return ResponseData.success(sysRoleService.list());
    }

    /**
     * 角色信息
     */
    @GetMapping("/info/{roleId}")
    @PreAuthorize("@pms.hasPermission('sys:role:info')")
    public ResponseData<SysRole> info(@PathVariable("roleId") Long roleId) {
        SysRole role = sysRoleService.getById(roleId);
        //查询角色对应的菜单
        List<Long> menuList = sysMenuService.listMenuIdByRoleId(roleId);
        role.setMenuIdList(menuList);
        return ResponseData.success(role);
    }

    /**
     * 保存角色
     */
    @SysLog("保存角色")
    @PostMapping
    @PreAuthorize("@pms.hasPermission('sys:role:save')")
    public ResponseData<String> save(@Valid @RequestBody SysRole role, BindingResult b) {
        sysRoleService.saveRoleAndRoleMenu(role);
        return ResponseData.success();
    }

    /**
     * 修改角色
     */
    @SysLog("修改角色")
    @PutMapping
    @PreAuthorize("@pms.hasPermission('sys:role:update')")
    public ResponseData<String> update(@Valid @RequestBody SysRole role, BindingResult b) {
        sysRoleService.updateRoleAndRoleMenu(role);
        return ResponseData.success();
    }

    /**
     * 删除角色
     */
    @SysLog("删除角色")
    @DeleteMapping
    @PreAuthorize("@pms.hasPermission('sys:role:delete')")
    public ResponseData<String> delete(@RequestBody Long[] roleIds) {
        sysRoleService.deleteBatch(roleIds);
        return ResponseData.success();
    }
}
