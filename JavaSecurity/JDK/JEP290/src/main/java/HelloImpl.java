import java.rmi.RemoteException;
import java.rmi.server.UnicastRemoteObject;

public class HelloImpl extends UnicastRemoteObject implements Hello {
    protected HelloImpl() throws RemoteException {
    }

    public String hello() throws RemoteException {
        return "hello world";
    }

    public String hello(String name) throws RemoteException {
        return "hello" + name;
    }

    public String hello(Object object) throws RemoteException {
        System.out.println(object);
        return "hello "+object.toString();
    }
}
