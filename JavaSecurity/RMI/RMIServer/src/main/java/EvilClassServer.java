import java.rmi.AlreadyBoundException;
import java.rmi.RemoteException;
import java.rmi.registry.LocateRegistry;
import java.rmi.registry.Registry;

public class EvilClassServer {
    public static void main(String[] args) throws RemoteException, AlreadyBoundException {
        User liming = new ServerReturnObject("liming",15);
        Registry registry = LocateRegistry.createRegistry(1099);
        registry.bind("user",liming);

        System.out.println("registry is running...");

        System.out.println("liming is bind in registry");
    }
}