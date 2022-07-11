package src.ReflectDemo;

import java.lang.reflect.Method;

public class ReflectionTest04 {
    public static void main(String[] args) throws Exception{
        Class c1 = Class.forName("src.Person");
        Object m = c1.newInstance();
        Method method = c1.getMethod("reflect");
        method.invoke(m);
    }
}
