package com.wlc.realm;

import com.wlc.dao.DAO;
import com.wlc.po.User;
import org.apache.shiro.authc.*;
import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.authz.SimpleAuthorizationInfo;
import org.apache.shiro.crypto.hash.SimpleHash;
import org.apache.shiro.realm.AuthorizingRealm;
import org.apache.shiro.subject.PrincipalCollection;

import java.util.Set;

/**
 * describe:
 *
 * @author 王立朝
 * @date 2019/10/25
 */
public class DatabaseRealm extends AuthorizingRealm {
    @Override
    protected AuthorizationInfo doGetAuthorizationInfo(PrincipalCollection principalCollection) {
        //获取用户名
        String userName = principalCollection.getPrimaryPrincipal().toString();
        //根据用户名获取用户的角色和权限
        Set<String> roleSet = new DAO().getRoles(userName);
        Set<String> permitSet = new DAO().getPermits(userName);

        //实例化一个授权对象，然后把用户名和密码放入到授权对象中
        SimpleAuthorizationInfo simpleAuthorizationInfo = new SimpleAuthorizationInfo();
        simpleAuthorizationInfo.setRoles(roleSet);
        simpleAuthorizationInfo.setStringPermissions(permitSet);
        return simpleAuthorizationInfo;
    }

    @Override
    protected AuthenticationInfo doGetAuthenticationInfo(AuthenticationToken authenticationToken) throws AuthenticationException {
        UsernamePasswordToken token = (UsernamePasswordToken) authenticationToken;
        //获取用户名
        String userName = token.getPrincipal().toString();
        //获取密码
        String passsword = new String(token.getPassword());
        //获取数据库中存放的用户名的密码和权限
        User user = new DAO().getUser(userName);
        String passwordInDb = user.getPassword();
        //获取盐
        String salt = user.getSalt();
        String encodePassword = new SimpleHash("md5",passsword,salt,2).toString();

        if(null == user || !encodePassword.equals(passwordInDb)){
            throw new AuthenticationException("认证失败");
        }
        //把用户名和密码放入到认证信息中
        SimpleAuthenticationInfo simpleAuthenticationInfo = new SimpleAuthenticationInfo(userName,passsword,getName());
        return simpleAuthenticationInfo;
    }
}
