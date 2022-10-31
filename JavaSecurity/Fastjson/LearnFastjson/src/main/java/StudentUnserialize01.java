import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.parser.Feature;


// 最开始的反序列化 demo
public class StudentUnserialize01 {
    public static void main(String[] args) {
        String jsonString = "{\"@type\":\"Student\",\"age\":0,\"cmd\":\"Calc\"}";
//        Object student1 = JSON.parseObject(jsonString);
        Object student1 = JSON.parseObject(jsonString,Object.class);

        System.out.println("parseObject: " + student1.getClass().getName());
    }
}
