import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.parser.Feature;


// 最开始的反序列化 demo
public class StudentUnserialize01 {
    public static void main(String[] args) {
        String jsonString = "{\"@type\":\"Student\",\"age\":0,\"name\":\"Drunkbaby\"}";
        Student student = JSON.parseObject(jsonString, Student.class, Feature.SupportNonPublicField);
        System.out.println(student);
        System.out.println(student.getClass().getName());
        System.out.println(student.getName() + " " + student.getAge());
    }
}
