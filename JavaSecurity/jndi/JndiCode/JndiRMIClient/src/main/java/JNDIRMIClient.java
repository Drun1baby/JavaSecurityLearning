import javax.naming.InitialContext;

public class JNDIRMIClient {
    public static void main(String[] args) throws Exception{
        InitialContext initialContext = new InitialContext();
        RemoteObj remoteObj = (RemoteObj) initialContext.lookup("rmi://localhost:1099/remoteObj");
        System.out.println(remoteObj.sayHello("hello"));
    }
}
