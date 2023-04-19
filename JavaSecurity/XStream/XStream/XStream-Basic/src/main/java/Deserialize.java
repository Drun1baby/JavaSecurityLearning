import com.thoughtworks.xstream.XStream;
import com.thoughtworks.xstream.io.xml.DomDriver;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.util.Scanner;

public class Deserialize {
    public static void main(String[] args) throws FileNotFoundException {
//        String xml = new Scanner(new File("person.xml")).useDelimiter("\\Z").next();
        FileInputStream xml = new FileInputStream("G:\\OneDrive - yapuu\\Java安全学习\\JavaSecurityLearning\\JavaSecurity\\XStream\\XStream\\XStream-Basic\\src\\main\\java\\person.xml");
        XStream xstream = new XStream(new DomDriver());
        Person p = (Person) xstream.fromXML(xml);
        p.output();
    }
}