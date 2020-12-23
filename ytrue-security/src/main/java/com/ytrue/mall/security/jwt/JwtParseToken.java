package com.ytrue.mall.security.jwt;

import cn.hutool.core.util.StrUtil;
import io.jsonwebtoken.Claims;
import io.jsonwebtoken.Jwts;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

import javax.servlet.http.HttpServletRequest;
import java.nio.charset.StandardCharsets;

@Component
public class JwtParseToken {

    @Value("${jjwt.signing.key}")
    private String SIGNING_KEY;

    @Autowired
    private HttpServletRequest request;

    public Claims getUserInfo() {
        String header = request.getHeader("Authorization");

        String token = header.substring(header.indexOf("bearer") + 7);
        return Jwts.parser()
                .setSigningKey(SIGNING_KEY.getBytes(StandardCharsets.UTF_8))
                .parseClaimsJws(token)
                .getBody();
    }
}
