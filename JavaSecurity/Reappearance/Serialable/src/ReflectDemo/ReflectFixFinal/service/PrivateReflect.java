package src.ReflectDemo.ReflectFixFinal.service;

import java.lang.reflect.Field;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;

public class PrivateReflect {
    public static void main(String[] args) throws ClassNotFoundException, NoSuchFieldException, IllegalAccessException, NoSuchMethodException, InstantiationException, InvocationTargetException {
        Class c = Class.forName("src.ReflectDemo.ReflectFixFinal.pojo.PrivatePerson");
        Object m = c.newInstance();
        Method PrintMethod = c.getDeclaredMethod("printName");
        PrintMethod.invoke(m);
        Field nameField = c.getDeclaredField("name");
        nameField.setAccessible(true);
        nameField.set(m, new StringBuilder("Drunkbaby Too Silly"));
        PrintMethod.invoke(m);
    }
}
