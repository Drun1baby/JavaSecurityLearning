import javax.naming.InitialContext;

// jndi 打 jdk8u191 之前版本的客户端
public class JNDILdapClient {
    public static void main(String[] args) throws Exception{
        InitialContext initialContext = new InitialContext();
        RemoteObj remoteObj = (RemoteObj) initialContext.lookup("ldap://localhost:1099/remoteObj");
        System.out.println(remoteObj.sayHello("hello"));
    }
}
