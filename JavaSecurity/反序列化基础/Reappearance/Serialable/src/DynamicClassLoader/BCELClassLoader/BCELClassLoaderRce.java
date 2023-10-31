package src.DynamicClassLoader.BCELClassLoader;


import com.sun.org.apache.bcel.internal.Repository;
import com.sun.org.apache.bcel.internal.classfile.JavaClass;
import com.sun.org.apache.bcel.internal.classfile.Utility;

// 利用 BCEL ClassLoader 加载字节码
public class BCELClassLoaderRce {
    public static void main(String[] args) throws Exception{
        Class calc = Class.forName("src.DynamicClassLoader.URLClassLoader.Calc");
        JavaClass javaClass = Repository.lookupClass(calc);
        String code = Utility.encode(javaClass.getBytes(), true);
        System.out.println(code);
    }
}
