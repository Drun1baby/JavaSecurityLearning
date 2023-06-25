import java.rmi.Naming;
import java.rmi.registry.LocateRegistry;

public class RMIServer {
    public static String HOST = "127.0.0.1";
    public static int PORT = 1099;
    public static String RMI_PATH = "/hello";
    public static final String RMI_NAME = "rmi://" + HOST + ":" + PORT + RMI_PATH;

    public static void main(String[] args) {
        try {
            // 注册RMI端口
            LocateRegistry.createRegistry(PORT);
            // 创建一个服务
            Hello hello = new HelloImpl();
            // 服务命名绑定
            Naming.rebind(RMI_NAME, hello);

            System.out.println("启动RMI服务在" + RMI_NAME);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
