package com.ytrue.mall.sys.service.impl;


import cn.hutool.core.collection.CollUtil;
import cn.hutool.core.collection.CollectionUtil;
import cn.hutool.core.convert.Convert;
import cn.hutool.core.lang.tree.Tree;
import cn.hutool.core.lang.tree.TreeNode;
import cn.hutool.core.lang.tree.TreeNodeConfig;
import cn.hutool.core.lang.tree.TreeUtil;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.ytrue.mall.sys.constant.Constant;
import com.ytrue.mall.sys.dao.SysMenuMapper;
import com.ytrue.mall.sys.dao.SysRoleMenuMapper;
import com.ytrue.mall.sys.dto.Meta;
import com.ytrue.mall.sys.model.SysMenu;
import com.ytrue.mall.sys.service.SysMenuService;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.*;
import java.util.stream.Collectors;

/**
 * @author ytrue
 */
@Service("sysMenuService")
@AllArgsConstructor
public class SysMenuServiceImpl extends ServiceImpl<SysMenuMapper, SysMenu> implements SysMenuService {

    private final SysRoleMenuMapper sysRoleMenuMapper;

    private final SysMenuMapper sysMenuMapper;


    @Override
    @Transactional(rollbackFor = Exception.class)
    public void deleteMenuAndRoleMenu(Long menuId) {
        //删除菜单
        this.removeById(menuId);
        //删除菜单与角色关联
        sysRoleMenuMapper.deleteByMenuId(menuId);
    }


    @Override
    public List<Long> listMenuIdByRoleId(Long roleId) {
        return sysMenuMapper.listMenuIdByRoleId(roleId);
    }


    @Override
    public List<SysMenu> listSimpleMenuNoButton() {
        return sysMenuMapper.listSimpleMenuNoButton();
    }

    @Override
    public List<SysMenu> listRootMenu() {
        return sysMenuMapper.listRootMenu();
    }

    @Override
    public List<SysMenu> listChildrenMenuByParentId(Long parentId) {
        return sysMenuMapper.listChildrenMenuByParentId(parentId);
    }

    @Override
    public List<SysMenu> listMenuAndBtn() {
        return sysMenuMapper.listMenuAndBtn();
    }

    @Override
    public List<Tree<String>> myRouter(Long userId) {
        List<SysMenu> menus = listMenuByUserId(userId);
        //配置
        TreeNodeConfig treeNodeConfig = new TreeNodeConfig();
        treeNodeConfig.setWeightKey("orderNum");
        treeNodeConfig.setNameKey("name");
        treeNodeConfig.setIdKey("menuId");
        // 最大递归深度
        //treeNodeConfig.setDeep(1);
        //插入数据
        List<TreeNode<String>> nodeList = CollUtil.newArrayList();
        for (SysMenu menu : menus) {

            Meta meta = new Meta(menu.getName(), menu.getIcon());
            Map<String, Object> map = new HashMap<>();

            if (menu.getType().equals(0)) {
                map.put("component", "Layout");
            } else {
                map.put("component", menu.getUrl());
            }
            map.put("path", menu.getUrl());
            map.put("meta", meta);
            nodeList.add(new TreeNode<>(
                    Convert.toStr(menu.getMenuId()),
                    Convert.toStr(menu.getParentId()),
                    menu.getName(),
                    menu.getOrderNum()).setExtra(map)
            );
        }
        return TreeUtil.build(nodeList, "0", treeNodeConfig, (treeNode, tree) -> {
            tree.setId(treeNode.getId());
            tree.setParentId(treeNode.getParentId());
            tree.setWeight(treeNode.getWeight());
            tree.setName(treeNode.getName());
            // 扩展属性 ...
            Map<String, Object> extra = treeNode.getExtra();
            tree.putExtra("path", extra.get("path"));
            tree.putExtra("component", extra.get("component"));
            tree.putExtra("meta", extra.get("meta"));
        });
    }


    /**
     * 获取用户菜单列表
     *
     * @param userId
     * @return
     */
    private List<SysMenu> listMenuByUserId(Long userId) {
        // 用户的所有菜单信息
        List<SysMenu> sysMenus;
        //系统管理员，拥有最高权限
        if (userId == Constant.SUPER_ADMIN_ID) {
            sysMenus = sysMenuMapper.listMenu();
        } else {
            sysMenus = sysMenuMapper.listMenuByUserId(userId);
        }
        return sysMenus;
    }

}
