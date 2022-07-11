package src.DynamicClassLoader.URLClassLoader;

import java.io.IOException;

// 弹计算器的万能类
public class Calc {
    static {
        try {
            Runtime.getRuntime().exec("calc");
        } catch (IOException e){
            e.printStackTrace();
        }
    }
}
