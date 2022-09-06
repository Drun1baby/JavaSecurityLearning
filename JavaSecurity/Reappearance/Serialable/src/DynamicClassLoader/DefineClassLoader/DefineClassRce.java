package src.DynamicClassLoader.DefineClassLoader;

import java.lang.reflect.Method;
import java.nio.file.Files;
import java.nio.file.Paths;

// 利用 ClassLoader#defineClass 直接加载字节码
public class DefineClassRce {
    public static void main(String[] args) throws Exception{
        ClassLoader classLoader = ClassLoader.getSystemClassLoader();
        Method method = ClassLoader.class.getDeclaredMethod("defineClass", String.class, byte[].class, int.class, int.class);
        method.setAccessible(true);
        byte[] code = Files.readAllBytes(Paths.get("E:\\Calc.class"));  // 字节码的数组
        Class c = (Class) method.invoke(classLoader, "Calc", code, 0, code.length);
        c.newInstance();
    }
}
