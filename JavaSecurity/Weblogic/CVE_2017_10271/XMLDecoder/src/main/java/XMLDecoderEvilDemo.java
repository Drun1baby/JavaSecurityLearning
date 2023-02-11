import java.beans.XMLDecoder;
import java.io.BufferedInputStream;
import java.io.FileInputStream;

// XML 反序列化漏洞的 Demo
public class XMLDecoderEvilDemo {
    public static void main(String[] args) throws Exception {
        FileInputStream file = new FileInputStream("F://poc.xml");
        XMLDecoder xmlDecoder = new XMLDecoder(new BufferedInputStream(file));
        Object result = xmlDecoder.readObject();
        xmlDecoder.close();
    }
}
