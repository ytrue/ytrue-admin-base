package com.ytrue.mall.common.util;

import io.jsonwebtoken.Claims;
import io.jsonwebtoken.Jwts;

public class JwtUtil {

    public static Claims parse(String token) {
        return Jwts.parser()
                //秘钥
                .setSigningKey("xxxx")
                .parseClaimsJws(token)
                .getBody();
    }
}
