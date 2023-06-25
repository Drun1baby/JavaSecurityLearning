import java.rmi.Remote;

// User 接口
public interface User extends Remote {
    public Object getUser() throws Exception;
}
