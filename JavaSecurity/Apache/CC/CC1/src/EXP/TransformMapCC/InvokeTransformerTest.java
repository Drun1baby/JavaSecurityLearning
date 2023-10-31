package TransformMapCC;

import org.apache.commons.collections.functors.InvokerTransformer;

import java.lang.reflect.Method;

// 用 InvokerTransformer 弹计算器
public class InvokeTransformerTest {
    public static void main(String[] args) {
        Runtime runtime = Runtime.getRuntime();
        InvokerTransformer invokerTransformer = new InvokerTransformer("exec"
                , new Class[]{String.class}, new Object[]{"calc"});
        invokerTransformer.transform(runtime);
    }
}
