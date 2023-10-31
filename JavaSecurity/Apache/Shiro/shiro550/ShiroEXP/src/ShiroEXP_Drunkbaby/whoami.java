

import java.io.ByteArrayOutputStream;
import java.io.InputStream;

// 使用 Runtime 类进行命令执行
public class whoami {
    public static void main(String[] args) throws Exception {
        InputStream inputStream = Runtime.getRuntime().exec("whoami").getInputStream();
        byte[] cache = new byte[1024];
        ByteArrayOutputStream byteArrayOutputStream = new ByteArrayOutputStream();
        int readLen = 0;
        while ((readLen = inputStream.read(cache))!=-1){
            byteArrayOutputStream.write(cache, 0, readLen);
        }
        System.out.println(byteArrayOutputStream);
    }
}
