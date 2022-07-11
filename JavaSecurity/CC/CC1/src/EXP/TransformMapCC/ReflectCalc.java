package TransformMapCC;

import org.omg.SendingContext.RunTime;

import java.lang.reflect.Method;

// 简单的反射
public class ReflectCalc {
    public static void main(String[] args) throws Exception{
        Runtime runtime = Runtime.getRuntime();
        Class c = Runtime.class;
        Method method = c.getDeclaredMethod("exec", String.class);
        method.setAccessible(true);
        method.invoke(runtime, "calc");
    }
}
