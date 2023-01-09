package com.shiro.vuln.Shiro;

import java.util.LinkedHashMap;
import org.apache.shiro.mgt.RememberMeManager;
import org.apache.shiro.mgt.SecurityManager;
import org.apache.shiro.realm.Realm;
import org.apache.shiro.spring.web.ShiroFilterFactoryBean;
import org.apache.shiro.web.mgt.CookieRememberMeManager;
import org.apache.shiro.web.mgt.DefaultWebSecurityManager;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class ShiroConfig {

    @Bean
    MainRealm mainRealm() {
        return new MainRealm();
    }

    @Bean
    RememberMeManager cookieRememberMeManager() {
        return new CookieRememberMeManager();
    }


    @Bean
    SecurityManager securityManager(MainRealm mainRealm, RememberMeManager cookieRememberMeManager) {
        DefaultWebSecurityManager manager = new DefaultWebSecurityManager();
        manager.setRealm((Realm)mainRealm);
        manager.setRememberMeManager(cookieRememberMeManager);
        return manager;
    }

    @Bean(name={"shiroFilter"})
    ShiroFilterFactoryBean shiroFilterFactoryBean(SecurityManager securityManager) {
        ShiroFilterFactoryBean bean = new ShiroFilterFactoryBean();
        bean.setSecurityManager(securityManager);
        bean.setLoginUrl("/login");
        bean.setUnauthorizedUrl("/unauth");
        LinkedHashMap<String, String> map = new LinkedHashMap<String, String>();
        map.put("/doLogin", "anon");
        map.put("/**", "user");
        bean.setFilterChainDefinitionMap(map);
        return bean;
    }
}

