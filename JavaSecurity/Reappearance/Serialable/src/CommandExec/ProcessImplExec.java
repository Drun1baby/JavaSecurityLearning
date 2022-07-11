package src.CommandExec;



import java.io.ByteArrayOutputStream;
import java.io.InputStream;
import java.lang.reflect.Method;
import java.util.Map;

// 使用 ProcessImpl 进行命令执行
public class ProcessImplExec {
    public static void main(String[] args) throws Exception{
        String[] cmds = new String[]{"whoami"};
        Class clazz = Class.forName("java.lang.ProcessImpl");
        Method method = clazz.getDeclaredMethod("start", String[].class, Map.class, String.class,
                                                ProcessBuilder.Redirect[].class, boolean.class);
        method.setAccessible(true);
        Process e = (Process) method.invoke(null, cmds, null, ".", null, true);
        InputStream inputStream = e.getInputStream();
        byte[] cache = new byte[1024];
        int readLen = 0;
        ByteArrayOutputStream byteArrayOutputStream = new ByteArrayOutputStream();
        while ((readLen = inputStream.read(cache)) != -1){
            byteArrayOutputStream.write(cache, 0, readLen);
        }
        System.out.println(byteArrayOutputStream);
    }
}
