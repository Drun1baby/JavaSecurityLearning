package src.DynamicClassLoader.URLClassLoader;

import java.io.IOException;

public class whoami {
    static {
        try {
            Runtime.getRuntime().exec("whoami");
        } catch (IOException e){
            e.printStackTrace();
        }
    }
}
