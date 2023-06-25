import java.rmi.Naming;
import java.rmi.RemoteException;

// 针对 Registry 的 list 鸡肋攻击
public class RegistryListAttack {
    public static void main(String[] args) throws Exception{
        RemoteObj remoteObj = new RemoteObj() {
            @Override
            public String sayHello(String keywords) throws RemoteException {
                return null;
            }
        };
        String[] s = Naming.list("rmi://127.0.0.1:1099");
        System.out.println(s);
    }
}
