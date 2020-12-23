package com.ytrue.mall.controller;

import io.jsonwebtoken.Jwts;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpServletRequest;
import java.nio.charset.StandardCharsets;

@RestController
public class TestController {

    @RequestMapping("test")
    public Object test(HttpServletRequest request) {

        String header = request.getHeader("Authorization");
        String token = header.substring(header.indexOf("bearer") + 7);

        /**
         * {
         * 	"exp": 1607149029, 过期时间
         * 	"user_name": "admin", 用户名
         * 	"authorities": [     权限
         * 		"admin"
         * 	],
         * 	"jti": "55ddadc8-3423-4ad9-afe9-7a7fcfbae288",
         * 	"client_id": "admin",
         * 	"scope": [
         * 		"all"
         * 	]
         * }
         */


        return Jwts.parser()
                .setSigningKey("33fk2#@@$@#456kke37we9334%#$".getBytes(StandardCharsets.UTF_8))
                .parseClaimsJws(token)
                .getBody();
    }
}
