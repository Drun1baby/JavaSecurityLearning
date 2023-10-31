package src.ReflectDemo.ReflectFixFinal.service;

import java.io.IOException;
import java.lang.reflect.Field;
import java.lang.reflect.Method;

public class StaticReflect {
    public static void main(String[] args) throws Exception {
        Class c = Class.forName("src.ReflectDemo.ReflectFixFinal.pojo.StaticPerson");
        Object m = c.newInstance();
        Method nameMethod = c.getDeclaredMethod("printInfo");
        nameMethod.invoke(m);
        Field nameField = c.getDeclaredField("name");
        nameField.setAccessible(true);
        nameField.set(m,new StringBuilder("Drunkbaby static Silly"));
        nameMethod.invoke(m);
    }
}
