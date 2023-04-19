import com.thoughtworks.xstream.XStream;
import com.thoughtworks.xstream.io.xml.DomDriver;

public class Serialize {
    public static void main(String[] args) {
        Person p = new Person();
        p.age = 6;
        p.name = "Drunkbaby";
        XStream xstream = new XStream(new DomDriver());
        String xml = xstream.toXML(p);
        System.out.println(xml);
    }
}