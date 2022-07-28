package src.ReflectDemo;

import java.lang.reflect.Method;

// 基本反射运用
public class FinalReflectionCalc {
    public static void main(String[] args) throws Exception{
       /*  失败，因为 java.lang.Runtime 是私有的
        Class c1 = Class.forName("java.lang.Runtime");
        Object o1 = c1.newInstance();
        Method m1 = c1.getDeclaredMethod("exec",String.class);
        m1.invoke(o1,"C:\\WINDOWS\\System32\\calc.exe");
        */

       // 代码冗长，改一改
        Class c1 = Class.forName("java.lang.Runtime");
        Method method = c1.getMethod("exec", String.class);
        Method RuntimeMethod = c1.getMethod("getRuntime");
        Object o1 = RuntimeMethod.invoke(c1);
        method.invoke(o1, "calc");

        // 最终版本
//        Class c1 = Class.forName("java.lang.Runtime");
//        c1.getMethod("exec", String.class).invoke(c1.getMethod("getRuntime").invoke(c1), "C:\\WINDOWS\\System32\\calc.exe");
    }

}
