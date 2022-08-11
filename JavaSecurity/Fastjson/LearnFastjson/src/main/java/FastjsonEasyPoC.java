import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.alibaba.fastjson.parser.Feature;

public class FastjsonEasyPoC {
    public static void main(String[] args){
        String jsonString ="{\"@type\":\"Student\",\"age\":6,\"name\":\"Drunkbaby\",\"address\":\"china\",\"properties\":{}}";

        Object obj = JSON.parseObject(jsonString, Object.class);
        System.out.println(obj);
        System.out.println(obj.getClass().getName());
    }
}