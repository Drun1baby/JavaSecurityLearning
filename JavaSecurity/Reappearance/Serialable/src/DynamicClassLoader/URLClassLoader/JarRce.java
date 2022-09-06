package src.DynamicClassLoader.URLClassLoader;

import java.net.URL;
import java.net.URLClassLoader;

// URLClassLoader 的 file + jar
public class JarRce {
    public static void main(String[] args) throws Exception{
        URLClassLoader urlClassLoader = new URLClassLoader(new URL[]{new URL("jar:file:///E:\\Calc.jar!/")});
        Class calc = urlClassLoader.loadClass("Calc");
        calc.newInstance();

    }
}
