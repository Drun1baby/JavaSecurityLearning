import sun.rmi.registry.RegistryImpl_Skel;

import java.lang.reflect.Proxy;
import java.rmi.Naming;
import java.rmi.Remote;
import java.rmi.registry.LocateRegistry;

// 针对 Registry 的 list 鸡肋攻击
public class RegistryListAttack {
    public static void main(String[] args) throws Exception{
        RemoteObj remoteObj = new RemoteObjImpl();
        LocateRegistry.createRegistry(1099);
        Naming.bind("rmi://127.0.0.1:1099/sayHello",remoteObj);
        String[] s = Naming.list("rmi://127.0.0.1:1099");
        System.out.println(s);
    }
}
