package shiro.config;

import org.apache.shiro.spring.web.ShiroFilterFactoryBean;
import org.apache.shiro.web.mgt.DefaultWebSecurityManager;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import java.util.LinkedHashMap;
import java.util.Map;

@Configuration
public class ShiroConfig {
    // ShiroFilterFactoryBean
    @Bean
    public ShiroFilterFactoryBean getShiroFilterFactoryBean(
            @Qualifier("getDefaultWebSecurityManager") DefaultWebSecurityManager defaultWebSecurityManager){
        ShiroFilterFactoryBean bean = new ShiroFilterFactoryBean();
        // 设置安全管理器
        bean.setSecurityManager(defaultWebSecurityManager);

        // 添加 shiro 的内置过滤器
        /*
        anon：无需认证即可访问
        authc：必须认证了才能访问
        user：必须拥有 记住我功能才能使用
        perms：拥有对某个资源的权限才能访问
        role：拥有某个角色权限
         */

        // 拦截
        Map<String, String > filterMap = new LinkedHashMap<>();

        filterMap.put("/user/add","perms[user:add]");
        filterMap.put("/user/update","perms[user:update]");

        filterMap.put("/user/*", "authc");
        filterMap.put("/**", "anon");
        bean.setFilterChainDefinitionMap(filterMap);

        bean.setLoginUrl("/toLogin");
        bean.setUnauthorizedUrl("/noauth");
        return bean;
    }

    // DefaultWebSecurityManager
    @Bean
    public DefaultWebSecurityManager getDefaultWebSecurityManager(@Qualifier("userRealm") UserRealm userRealm){
        DefaultWebSecurityManager securityManager = new DefaultWebSecurityManager();

        // 关联 UserRealm
        securityManager.setRealm(userRealm);
        return securityManager;
    }

    // 创建 realm 对象
    @Bean
    public UserRealm userRealm(){
        return new UserRealm();
    }
}
