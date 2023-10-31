package src.ReflectDemo.ReflectFixFinal.service;

import java.lang.reflect.Field;
import java.lang.reflect.Method;
import java.lang.reflect.Modifier;

public class StaticFinalReflect {
    public static void main(String[] args) throws Exception {
        Class c = Class.forName("src.ReflectDemo.ReflectFixFinal.pojo.StaticFinalPerson");
        Object m = c.newInstance();
        Method printMethod = c.getDeclaredMethod("printInfo");
        printMethod.invoke(m);

        Field nameField = c.getDeclaredField("name");
        nameField.setAccessible(true);
        Field nameModifyField = nameField.getClass().getDeclaredField("modifiers");
        nameModifyField.setAccessible(true);
        nameModifyField.setInt(nameField, nameField.getModifiers() & ~Modifier.FINAL);
        nameField.set(m,new StringBuilder("Drunkbaby Too Silly"));
        nameModifyField.setInt(nameField, nameField.getModifiers() & ~Modifier.FINAL);
        printMethod.invoke(m);
    }
}
