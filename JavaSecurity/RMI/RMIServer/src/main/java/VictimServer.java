import java.rmi.Naming;
import java.rmi.RemoteException;
import java.rmi.registry.LocateRegistry;
import java.rmi.server.UnicastRemoteObject;

public class VictimServer {
    public class RemoteHelloWorld extends UnicastRemoteObject implements RemoteObj {
        protected RemoteHelloWorld() throws RemoteException {
            super();
        }

        public String hello() throws RemoteException {
            System.out.println("调用了hello方法");
            return "Hello world";
        }

        public void evil(Object obj) throws RemoteException {
            System.out.println("调用了evil方法，传递对象为："+obj);
        }

        @Override
        public String sayHello(String keywords) throws RemoteException {
            return null;
        }
    }
    private void start() throws Exception {
        RemoteHelloWorld h = new RemoteHelloWorld();
        LocateRegistry.createRegistry(1099);
        Naming.rebind("rmi://127.0.0.1:1099/sayHello", h);
    }

    public static void main(String[] args) throws Exception {
        new VictimServer().start();
    }
}
