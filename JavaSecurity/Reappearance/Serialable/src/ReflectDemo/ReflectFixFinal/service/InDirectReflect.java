package src.ReflectDemo.ReflectFixFinal.service;

import java.lang.reflect.Field;
import java.lang.reflect.Method;

public class InDirectReflect {
    public static void main(String[] args) throws Exception {
        Class c = Class.forName("src.ReflectDemo.ReflectFixFinal.pojo.InDirectPerson");
        Object m = c.newInstance();
        Method printMethod = c.getDeclaredMethod("printInfo");
        printMethod.invoke(m);

        Field nameField = c.getDeclaredField("name");
        Field ageField = c.getDeclaredField("age");
        Field sexField = c.getDeclaredField("sex");
        nameField.setAccessible(true);
        ageField.setAccessible(true);
        sexField.setAccessible(true);
        nameField.set(m,"Drunkbaby Too Silly");
        ageField.set(m,180);
        sexField.set(m,new StringBuilder("female"));
        printMethod.invoke(m);
    }
}
