package src.JdkProxy.StaticProxy;

// 启动器
public class Client01 {
    public static void main(String[] args) {
        Host host = new Host();
        Proxy proxy = new Proxy(host);
        proxy.rent();
    }
}
