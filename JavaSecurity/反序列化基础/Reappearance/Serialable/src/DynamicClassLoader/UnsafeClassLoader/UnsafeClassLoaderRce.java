package src.DynamicClassLoader.UnsafeClassLoader;


// 利用 Unsafe 中的 defineClass 加载字节码
import sun.misc.Unsafe;

import java.lang.reflect.Field;
import java.lang.reflect.Method;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.security.ProtectionDomain;

public class UnsafeClassLoaderRce {
    public static void main(String[] args) throws Exception{
        ClassLoader classLoader = ClassLoader.getSystemClassLoader();
        Class<Unsafe> unsafeClass = Unsafe.class;
        Field unsafeField = unsafeClass.getDeclaredField("theUnsafe");
        unsafeField.setAccessible(true);
        Unsafe classUnsafe = (Unsafe) unsafeField.get(null);
        Method defineClassMethod = unsafeClass.getMethod("defineClass", String.class, byte[].class,
                int.class, int.class, ClassLoader.class, ProtectionDomain.class);
        byte[] code = Files.readAllBytes(Paths.get("E:\\JavaClass\\Calc.class"));
        Class calc = (Class) defineClassMethod.invoke(classUnsafe, "Calc", code, 0, code.length, classLoader, null);
        calc.newInstance();
    }
}
