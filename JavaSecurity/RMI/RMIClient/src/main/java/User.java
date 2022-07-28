import java.rmi.Remote;

public interface User extends Remote {
    public Object getUser() throws Exception;
}
