
package com.shiro.vuln.Shiro;

import org.apache.shiro.authc.*;
import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.realm.AuthorizingRealm;
import org.apache.shiro.subject.PrincipalCollection;

public class MainRealm extends AuthorizingRealm {
    // 用于授权
    protected AuthorizationInfo doGetAuthorizationInfo(PrincipalCollection principalCollection) {
        // 获取当前授权的用户
        return null;
    }

    // 用于认证
    protected AuthenticationInfo doGetAuthenticationInfo(AuthenticationToken authenticationToken) throws AuthenticationException {
        // getPrincipal 获取当前用户身份
        String username = (String)authenticationToken.getPrincipal();
        // 获取当前用户信用凭证 （其实就是获取密码 密码是 char类型的所以要转一下
        String password = new String((char[])authenticationToken.getCredentials());
        // 如果等于就返回对应的用户凭证
        if (username.equals("admin") && password.equals("admin")) {
            // shiro 会返回一个 AuthenticationInfo
            // 当前的realm名字
            return new SimpleAuthenticationInfo((Object)username, (Object)password, this.getName());
        }
        throw new IncorrectCredentialsException("Username or password is incorrect.");
    }
}

