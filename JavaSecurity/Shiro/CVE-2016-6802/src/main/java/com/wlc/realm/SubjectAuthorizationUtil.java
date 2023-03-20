package com.wlc.realm;

import org.apache.shiro.SecurityUtils;

import java.util.Collection;
import java.util.List;

/**
 * describe:
 *
 * @author 王立朝
 * @date 2019/10/25
 */
public  class SubjectAuthorizationUtil {


    public static Collection<String> getAuthorizationRoles(){
        DatabaseRealm databaseRealm = new DatabaseRealm();
        Collection<String> stringList = databaseRealm.doGetAuthorizationInfo(SecurityUtils.getSubject().getPrincipals()).getRoles();
        return stringList;
    }
    public static Collection<String> getAuthorizationPerms(){
        DatabaseRealm databaseRealm = new DatabaseRealm();
        Collection<String> stringList = databaseRealm.doGetAuthorizationInfo(SecurityUtils.getSubject().getPrincipals()).getStringPermissions();
        return stringList;
    }
}
