import java.rmi.Remote;
import java.rmi.RemoteException;

public interface Hello extends Remote {
    String hello() throws RemoteException;
    String hello(String name) throws RemoteException;
    String hello(Object object) throws RemoteException;
}
