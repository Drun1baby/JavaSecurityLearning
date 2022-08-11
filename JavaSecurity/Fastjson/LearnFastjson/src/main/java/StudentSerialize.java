import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.serializer.SerializerFeature;

// 最开始的序列化 demo
public class StudentSerialize {
    public static void main(String[] args) {
        Student student = new Student();
        student.setName("Drunkbaby");
//        student.setAge(6);
        String jsonString = JSON.toJSONString(student, SerializerFeature.WriteClassName);
        System.out.println(jsonString);
    }
}
