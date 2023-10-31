import javax.naming.Context;
import javax.naming.InitialContext;
import java.util.Properties;

public class JNDIRMIClient {
    public static void main(String[] args) throws Exception{
        Properties env = new Properties();
        env.put(Context.INITIAL_CONTEXT_FACTORY, "com.sun.jndi.rmi.registry.RegistryContextFactory");
        env.put(Context.PROVIDER_URL, "rmi://127.0.0.1:1099");
        Context ctx = new InitialContext(env);
        String uri = "rmi://127.0.0.1:1099/Exploit";
        ctx.lookup(uri);
    }
}
