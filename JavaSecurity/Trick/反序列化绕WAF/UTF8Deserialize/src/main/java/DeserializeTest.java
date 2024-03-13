import org.example.Evil;

import java.io.*;

public class DeserializeTest {

    public static void main(String[] args) throws Exception {
        Evil evil = new Evil();
    //    serialize(evil);
        deserialize("ser.bin");
    }

    static void serialize(Object obj) throws IOException {
        ObjectOutputStream oos = new ObjectOutputStream(new FileOutputStream("ser.bin"));
        oos.writeObject(obj);
    }

    static Object deserialize(String Filename) throws IOException, ClassNotFoundException {
        ObjectInputStream ois = new ObjectInputStream(new FileInputStream(Filename));
        Object obj = ois.readObject();
        return obj;
    }

}