

import java.net.MalformedURLException;
import java.rmi.AlreadyBoundException;
import java.rmi.Naming;
import java.rmi.Remote;
import java.rmi.RemoteException;
import java.rmi.registry.LocateRegistry;
import java.rmi.registry.Registry;

public class RMIServer {
    public static void main(String[] args) throws RemoteException, AlreadyBoundException, MalformedURLException {
        // 实例化远程对象
        RemoteObj remoteObj = new RemoteObjImpl();
        // 创建注册中心
        Registry registry = LocateRegistry.createRegistry(1099);
        // 绑定对象示例到注册中心
        registry.bind("remoteObj", remoteObj);
    }
}
