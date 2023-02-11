import java.beans.XMLDecoder;
import java.io.BufferedInputStream;
import java.io.FileInputStream;

public class DecoderExample {
    public static void main(String[] args) throws Exception {
        FileInputStream file = new FileInputStream("result.xml");
        XMLDecoder xmlDecoder = new XMLDecoder(new BufferedInputStream(file));
        Object o = xmlDecoder.readObject();
        System.out.println(o);
        xmlDecoder.close();
    }
}
