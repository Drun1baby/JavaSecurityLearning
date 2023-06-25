import java.rmi.Remote;
import java.rmi.RemoteException;
import java.rmi.server.UnicastRemoteObject;
import java.util.Locale;

public class RemoteObjImpl extends UnicastRemoteObject implements RemoteObj {

    public RemoteObjImpl() throws RemoteException {
   //     UnicastRemoteObject.exportObject(this, 0); // 如果不能继承 UnicastRemoteObject 就需要手工导出
    }

    @Override
    public String sayHello(String keywords) throws RemoteException {
        String upKeywords = keywords.toUpperCase();
        System.out.println(upKeywords);
        return upKeywords;
    }
}
