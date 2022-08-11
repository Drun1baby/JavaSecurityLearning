import com.alibaba.fastjson.JSON;

public class StudentUnserialize02 {
    public static void main(String[] args) {
        String jsonString ="{\"@type\":\"Student\",\"age\":6," +
                "\"name\":\"Drunkbaby\",\"address\":\"china\",\"properties\":{}}";
        Object obj = JSON.parseObject(jsonString, Student.class);
        // 或以下语句，输出结果一致
        //JSONObject obj = JSON.parseObject(jsonString);
        System.out.println(obj);
        System.out.println(obj.getClass().getName());
    }
}
