package com.ytrue.mall.sys.controller;

import cn.hutool.core.util.StrUtil;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.ytrue.mall.common.annotation.SysLog;
import com.ytrue.mall.common.exeption.CustomValidateException;
import com.ytrue.mall.common.util.ResponseData;
import com.ytrue.mall.sys.constant.Constant;
import com.ytrue.mall.sys.constant.MenuType;
import com.ytrue.mall.sys.model.SysMenu;
import com.ytrue.mall.sys.service.SysMenuService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.List;
import java.util.Objects;

/**
 * 系统菜单
 *
 * @author ytrue
 */
@RestController
@RequestMapping("/sys/menu")
public class SysMenuController {

    @Autowired
    private SysMenuService sysMenuService;

    /**
     * 获取菜单页面的表
     *
     * @return
     */
    @GetMapping("/table")
    public ResponseData<List<SysMenu>> table() {
        return ResponseData.success(sysMenuService.list(
                new QueryWrapper<SysMenu>().orderByAsc("order_num")));
    }


    /**
     * 获取用户所拥有的菜单(不包括按钮)
     * 所有菜单列表(用于新建、修改角色时 获取菜单的信息)
     */
    @GetMapping("/list")
    public ResponseData<List<SysMenu>> list() {
        return ResponseData.success(sysMenuService.list(
                new QueryWrapper<SysMenu>().ne("type", 2).orderByAsc("order_num")));
    }

    /**
     * 菜单信息
     */
    @GetMapping("/info/{menuId}")
    @PreAuthorize("@pms.hasPermission('sys:menu:info')")
    public ResponseData<SysMenu> info(@PathVariable("menuId") Long menuId) {
        SysMenu menu = sysMenuService.getById(menuId);
        return ResponseData.success(menu);
    }

    /**
     * 保存
     */
    @SysLog("保存菜单")
    @PostMapping
    @PreAuthorize("@pms.hasPermission('sys:menu:save')")
    public ResponseData<String> save(@Valid @RequestBody SysMenu menu, BindingResult b) {
        //数据校验
        verifyForm(menu);
        sysMenuService.save(menu);
        return ResponseData.success();
    }


    /**
     * 修改
     */
    @SysLog("修改菜单")
    @PutMapping
    @PreAuthorize("@pms.hasPermission('sys:menu:update')")
    public ResponseData<String> update(@Valid @RequestBody SysMenu menu, BindingResult b) {
        //数据校验
        verifyForm(menu);
        if (menu.getType() == MenuType.MENU.getValue()) {
            if (StrUtil.isBlank(menu.getUrl())) {
                return ResponseData.fail("菜单URL不能为空");
            }
        }
        sysMenuService.updateById(menu);
        return ResponseData.success();
    }

    /**
     * 删除
     */
    @SysLog("删除菜单")
    @DeleteMapping("/{menuId}")
    @PreAuthorize("@pms.hasPermission('sys:menu:delete')")
    public ResponseData<String> delete(@PathVariable Long menuId){
        if(menuId <= Constant.SYS_MENU_MAX_ID){
            throw new CustomValidateException("系统菜单，不能删除");
        }
        //判断是否有子菜单或按钮
        List<SysMenu> menuList = sysMenuService.listChildrenMenuByParentId(menuId);
        if(menuList.size() > 0){
            throw new CustomValidateException("请先删除子菜单或按钮");
        }
        sysMenuService.deleteMenuAndRoleMenu(menuId);
        return ResponseData.success();
    }


    /**
     * 验证参数是否正确
     */
    private void verifyForm(SysMenu menu) {

        if (menu.getType() == MenuType.MENU.getValue()) {
            if (StrUtil.isBlank(menu.getUrl())) {
                throw new CustomValidateException("菜单URL不能为空");
            }
        }
        if (Objects.equals(menu.getMenuId(), menu.getParentId())) {
            throw new CustomValidateException("自己不能是自己的上级");
        }

        //上级菜单类型
        int parentType = MenuType.CATALOG.getValue();
        if (menu.getParentId() != 0) {
            SysMenu parentMenu = sysMenuService.getById(menu.getParentId());
            parentType = parentMenu.getType();
        }

        //目录、菜单
        if (menu.getType() == MenuType.CATALOG.getValue() ||
                menu.getType() == MenuType.MENU.getValue()) {
            if (parentType != MenuType.CATALOG.getValue()) {
                throw new CustomValidateException("上级菜单只能为目录类型");
            }
            return;
        }

        //按钮
        if (menu.getType() == MenuType.BUTTON.getValue()) {
            if (parentType != MenuType.MENU.getValue()) {
                throw new CustomValidateException("上级菜单只能为菜单类型");
            }
        }
    }
}
