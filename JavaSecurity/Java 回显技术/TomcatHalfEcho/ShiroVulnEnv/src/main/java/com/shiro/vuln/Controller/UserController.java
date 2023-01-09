package com.shiro.vuln.Controller;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.AuthenticationToken;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.subject.Subject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class UserController {


    @PostMapping("/doLogin")
    public String doLoginPage(@RequestParam("username") String username, @RequestParam("password") String password, @RequestParam(name="rememberme", defaultValue="") String rememberMe){
        Subject subject = SecurityUtils.getSubject();
        try {
            subject.login((AuthenticationToken)new UsernamePasswordToken(username, password, rememberMe.equals("remember-me")));
        // 如果认证失败
        }catch (AuthenticationException e) {
            return "forward:/login";
        }
        return "forward:/";
    }

    @ResponseBody
    @RequestMapping(value={"/"})
    public String helloPage() {
        return "hello";
    }

    @ResponseBody
    @RequestMapping(value={"/unauth"})
    public String errorPage() {
        return "error";
    }

    @ResponseBody
    @RequestMapping(value={"/login"})
    public String loginPage() {
        return "please login pattern /doLogin";
    }
}
