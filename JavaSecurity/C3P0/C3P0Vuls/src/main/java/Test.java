import com.sun.jndi.dns.DnsName;

import javax.naming.InvalidNameException;
import java.lang.reflect.Field;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;


// 自己挖掘 JNDI 注入的失败
public class Test {
    public static void main(String[] args) throws ClassNotFoundException, NoSuchMethodException, NoSuchFieldException, IllegalAccessException, InstantiationException, InvocationTargetException, InvalidNameException {
        Class clazz = Class.forName("com.mchange.v2.naming.ReferenceIndirector$ReferenceSerialized");
        Method method = clazz.getDeclaredMethod("getObject");
        Field ContextField = clazz.getDeclaredField("contextName");
        ContextField.setAccessible(true);
        DnsName dnsName = new DnsName();
        ContextField.set(dnsName,dnsName);
        Object o = method.invoke(clazz);
        method.invoke(o);
    }
}
