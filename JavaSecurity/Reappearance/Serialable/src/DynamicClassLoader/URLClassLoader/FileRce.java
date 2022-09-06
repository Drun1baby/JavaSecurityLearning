package src.DynamicClassLoader.URLClassLoader;

import java.net.URL;
import java.net.URLClassLoader;

// URLClassLoader 的 file 协议
public class FileRce {
    public static void main(String[] args) throws Exception {
        URLClassLoader urlClassLoader = new URLClassLoader
                (new URL[]{new URL("file:///E:\\")});
        Class calc = urlClassLoader.loadClass("Calc");
        calc.newInstance();
    }
}
