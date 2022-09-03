package src.ReflectDemo;

import java.lang.reflect.Constructor;
import java.lang.reflect.Method;

// invoke 触发被修改的方法
public class ReflectionTest06 {
    public static void main(String[] args) throws Exception {
        Class c = Class.forName("src.ReflectDemo.Person");
        Object m = c.newInstance();
        // newInstance() 与 invoke() 一起使用
        Method method = c.getMethod("reflect");
        method.invoke(m);

        System.out.println("---------分割线--------");

//        Constructor constructor = c.getDeclaredConstructor(String.class, int.class);
//        Person p = (Person) constructor.newInstance("Drunkbaby", 19);
        // getMethod 并用 invoke 触发
        Method studyMethod = c.getMethod("study", String.class);
        studyMethod.invoke(m, "writing Code");

        System.out.println("---------分割线--------");

        Method sleepMethod = c.getDeclaredMethod("sleep", int.class);
        sleepMethod.setAccessible(true);
        sleepMethod.invoke(m, 3);
    }
}
