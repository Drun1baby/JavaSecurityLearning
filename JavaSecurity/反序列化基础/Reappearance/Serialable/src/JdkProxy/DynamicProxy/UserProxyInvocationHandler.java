package src.JdkProxy.DynamicProxy;

import java.lang.reflect.InvocationHandler;
import java.lang.reflect.Method;
import java.lang.reflect.Proxy;

public class UserProxyInvocationHandler implements InvocationHandler {

    // 被代理的接口
    private UserService userService;

    public void setUserService(UserService userService) {
        this.userService = userService;
    }

    // 动态生成代理类实例
    public Object getProxy(){
        Object obj = Proxy.newProxyInstance(this.getClass().getClassLoader(), userService.getClass().getInterfaces(), this);
        return obj;
    }

    // 处理代理类实例，并返回结果
    @Override
    public Object invoke(Object proxy, Method method, Object[] args) throws Throwable {
        log(method);
        Object obj = method.invoke(userService, args);
        return obj;
    }

    //业务自定义需求
    public void log(Method method){
        System.out.println("[Info] " + method.getName() + "方法被调用");
    }
}
