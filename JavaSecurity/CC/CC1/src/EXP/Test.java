import java.io.FileInputStream;
import java.io.IOException;
import java.io.ObjectInputStream;
import java.io.Serializable;

public class Test implements Serializable {
    public static void main(String[] args) throws IOException, ClassNotFoundException {
        unserialize("ser.bin");
    }

    public static Object unserialize(String Filename) throws IOException, ClassNotFoundException{
        ObjectInputStream ois = new ObjectInputStream(new FileInputStream(Filename));
        Object obj = ois.readObject();

        return obj;
    }
}
