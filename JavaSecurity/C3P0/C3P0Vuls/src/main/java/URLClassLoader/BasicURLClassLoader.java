package URLClassLoader;

import java.io.IOException;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLClassLoader;

// 简单的 URLClassLoader
public class BasicURLClassLoader {
    public static void main(String[] args) throws IOException, ClassNotFoundException, InstantiationException, IllegalAccessException {
        URLClassLoader urlClassLoader = new URLClassLoader(new URL[]{new URL("http://127.0.0.1:9999/")});
        Class calc = urlClassLoader.loadClass("Calc");
        calc.newInstance();
    }
}
