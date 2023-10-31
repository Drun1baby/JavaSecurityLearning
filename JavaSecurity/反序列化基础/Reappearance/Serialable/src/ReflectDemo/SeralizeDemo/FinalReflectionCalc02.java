package src.ReflectDemo.SeralizeDemo;

import java.lang.reflect.Constructor;

// 进阶使用反射
public class FinalReflectionCalc02 {
    public static void main(String[] args) throws Exception{
        Class c1 = Class.forName("java.lang.Runtime");
        Constructor m = c1.getDeclaredConstructor();
        m.setAccessible(true);
        c1.getMethod("exec", String.class).invoke(m.newInstance(),"C:\\WINDOWS\\System32\\calc.exe");
    }
}
