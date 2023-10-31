package src.CommandExec;



import java.io.ByteArrayOutputStream;
import java.io.InputStream;

// 使用 ProcessBuilder 进行命令执行操作
public class ProcessBuilderExec {
    public static void main(String[] args) throws Exception{
        InputStream inputStream = new ProcessBuilder("whoami").start().getInputStream();
        byte[] cache = new byte[1024];
        int readLen = 0;
        ByteArrayOutputStream byteArrayOutputStream = new ByteArrayOutputStream();
        while ((readLen = inputStream.read(cache)) != -1){
            byteArrayOutputStream.write(cache, 0, readLen);
        }
        System.out.println(byteArrayOutputStream);
    }
}
