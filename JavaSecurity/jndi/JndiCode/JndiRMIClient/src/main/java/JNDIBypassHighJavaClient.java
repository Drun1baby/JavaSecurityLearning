import org.apache.naming.factory.BeanFactory;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.spi.NamingManager;

public class JNDIBypassHighJavaClient {
    public static void main(String[] args) throws Exception {
        String uri = "rmi://localhost:1099/Object";
        Context context = new InitialContext();
        context.lookup(uri);
    }
}