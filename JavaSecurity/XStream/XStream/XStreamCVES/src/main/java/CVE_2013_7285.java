import com.thoughtworks.xstream.XStream;
import com.thoughtworks.xstream.io.xml.DomDriver;

import java.io.FileInputStream;

// CVE_2013_7285 Exploit
public class CVE_2013_7285 {
    public static void main(String[] args) throws Exception{
        FileInputStream fileInputStream = new FileInputStream("G:\\OneDrive - yapuu\\Java安全学习\\JavaSecurityLearning\\JavaSecurity\\XStream\\XStream\\XStream-Basic\\src\\main\\java\\person.xml");
        XStream xStream = new XStream(new DomDriver());
        xStream.fromXML(fileInputStream);
    }
}
