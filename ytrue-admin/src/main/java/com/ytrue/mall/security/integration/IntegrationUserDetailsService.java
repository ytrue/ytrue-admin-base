package com.ytrue.mall.security.integration;

import cn.hutool.core.util.StrUtil;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.ytrue.mall.common.exeption.CustomValidateException;
import com.ytrue.mall.sys.dto.User;
import com.ytrue.mall.security.integration.authenticator.IntegrationAuthenticator;
import com.ytrue.mall.sys.constant.Constant;
import com.ytrue.mall.sys.dao.SysMenuMapper;
import com.ytrue.mall.sys.dao.SysUserMapper;
import com.ytrue.mall.sys.model.SysMenu;
import com.ytrue.mall.sys.model.SysUser;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.AuthorityUtils;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.Arrays;
import java.util.List;
import java.util.Set;
import java.util.stream.Collectors;

/**
 * 集成认证-用户细节服务
 */
@Service
@Slf4j
public class IntegrationUserDetailsService implements UserDetailsService {

    @Autowired
    private PasswordEncoder passwordEncoder;

    @Autowired
    private SysMenuMapper sysMenuMapper;

    @Autowired
    private SysUserMapper sysUserMapper;

    private List<IntegrationAuthenticator> authenticators;


    @Autowired(required = false)
    public void setIntegrationAuthenticators(List<IntegrationAuthenticator> authenticators) {
        this.authenticators = authenticators;
    }

    @Override
    public UserDetails loadUserByUsername(String s) throws UsernameNotFoundException {
        log.info("我是IntegrationUserDetailsService：我被执行到了");
        //去获得上下文
        IntegrationAuthenticationEntity entity = IntegrationAuthenticationContext.get();
        //判断是否为空
        if (entity == null) {
            entity = new IntegrationAuthenticationEntity();
        }
        //判断是否支持集成认证类型
        SysUser user = (SysUser) authenticate(entity);
        //传递
        List<GrantedAuthority> authorityList = AuthorityUtils.createAuthorityList(getUserPermissions(user.getUserId()).toArray(new String[0]));
        return new User(user.getUsername(), user.getPassword(), "https://wpimg.wallstcn.com/f778738c-e4f8-4870-b634-56703b4acafe.gif", authorityList, user.getUserId());
    }


    //获得权限
    private Set<String> getUserPermissions(Long userId) {
        List<String> permsList;
        //系统管理员，拥有最高权限
        if (userId == Constant.SUPER_ADMIN_ID) {
            List<SysMenu> menuList = sysMenuMapper.selectList(Wrappers.emptyWrapper());
            permsList = menuList.stream().map(SysMenu::getPerms).collect(Collectors.toList());
        } else {
            permsList = sysUserMapper.queryAllPerms(userId);
        }
        return permsList.stream().flatMap((perms) -> {
                    if (StrUtil.isBlank(perms)) {
                        return null;
                    }
                    return Arrays.stream(perms.trim().split(","));
                }
        ).collect(Collectors.toSet());
    }

    /**
     * 判断是否支持集成认证类型
     *
     * @param entity
     * @return
     */
    private Object authenticate(IntegrationAuthenticationEntity entity) {
        if (this.authenticators != null) {
            for (IntegrationAuthenticator authenticator : authenticators) {
                if (authenticator.support(entity)) {
                    return authenticator.authenticate(entity);
                }
            }
        }
        throw new CustomValidateException("无效的auth_type参数值！");
    }
}
