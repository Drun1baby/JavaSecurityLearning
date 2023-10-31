package src.ReflectDemo.ReflectFixFinal.service;

import java.lang.reflect.Field;
import java.lang.reflect.Method;
import java.lang.reflect.Modifier;

public class PrivateFinalReflect {
    public static void main(String[] args) throws Exception {
        Class c = Class.forName("src.ReflectDemo.ReflectFixFinal.pojo.PrivateFinalPerson");
        Object m = c.newInstance();
        Field nameField = c.getDeclaredField("name");
        Field modifiersField = Field.class.getDeclaredField("modifiers");
        Method printMethod = c.getDeclaredMethod("printName");
        modifiersField.setAccessible(true);
        modifiersField.setInt(nameField, nameField.getModifiers() & ~Modifier.FINAL);
        nameField.setAccessible(true);
        nameField.set(m, new StringBuilder("Drunkbaby Too Silly"));
        printMethod.invoke(m);
    }
}
