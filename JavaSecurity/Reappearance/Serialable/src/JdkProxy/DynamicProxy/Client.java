package src.JdkProxy.DynamicProxy;

public class Client {
    public static void main(String[] args) {
        // 真实角色
        UserServiceImpl userServiceImpl = new UserServiceImpl();
        // 代理角色，不存在
        UserProxyInvocationHandler userProxyInvocationHandler = new UserProxyInvocationHandler();
        userProxyInvocationHandler.setUserService((UserService) userServiceImpl); // 设置要代理的对象

        // 动态生成代理类
        UserService proxy = (UserService) userProxyInvocationHandler.getProxy();

        proxy.add();
        proxy.delete();
        proxy.update();
        proxy.query();
    }
}
