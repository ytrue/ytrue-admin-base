package com.ytrue.mall.security.integration.authenticator;

import cn.hutool.core.util.StrUtil;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.ytrue.mall.common.exeption.CustomValidateException;
import com.ytrue.mall.security.integration.IntegrationAuthenticationEntity;
import com.ytrue.mall.sys.model.SysUser;
import com.ytrue.mall.sys.service.SysUserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Primary;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Component;
import org.springframework.util.StringUtils;

/**
 * 普通认证器（用户名+密码）
 */
@Component
/**
 * service有多个实现类的时候，注入的时候需要按照@Qualifier() 注入，
 * 加了@Primary 可以实现一个默认的注入类
 */
@Primary
public class UsernamePasswordAuthenticator extends AbstractPreparableIntegrationAuthenticator {

    @Autowired
    private SysUserService userService;

    /**
     * 预处理
     *
     * @param entity 集成认证实体
     * @return
     */
    @Override
    public SysUser authenticate(IntegrationAuthenticationEntity entity) {
        String username = entity.getAuthParameter("username");
        String password = entity.getAuthParameter("password");
        if (StrUtil.hasBlank(username) || StrUtil.hasBlank(password)) {
            throw new CustomValidateException("用户名或密码不能为空");
        }
        SysUser user = userService.getOne(new QueryWrapper<SysUser>().eq("username", username));
        if (user == null) {
            throw new CustomValidateException("用户不存在");
        }
        BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
        if (!passwordEncoder.matches(password, user.getPassword())) {
            throw new CustomValidateException("密码不正确");
        }

        return user;
        // return new UserPojo(2, "usernameAndPassword-yang", "17687410790", "yang@qq.com", "123456");
    }

    /**
     * 结束
     *
     * @param entity 集成认证实体
     * @return
     */
    @Override
    public boolean support(IntegrationAuthenticationEntity entity) {
        return StringUtils.isEmpty(entity.getAuthType());
    }
}
