import javax.swing.*;
import java.beans.XMLEncoder;
import java.io.BufferedOutputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;

public class EncoderExample {
    public static void main(String[] args) throws FileNotFoundException {
        FileOutputStream file = new FileOutputStream("result.xml");
        XMLEncoder xmlEncoder = new XMLEncoder(new BufferedOutputStream(file));
        xmlEncoder.writeObject(new JButton("Hello,xml"));
        xmlEncoder.close();
    }
}
