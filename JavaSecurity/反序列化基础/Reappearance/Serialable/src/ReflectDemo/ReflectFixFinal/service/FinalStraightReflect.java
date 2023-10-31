package src.ReflectDemo.ReflectFixFinal.service;

import java.lang.reflect.Field;
import java.lang.reflect.Method;

// 直接用反射修改值，是会报错的
public class FinalStraightReflect {
    public static void main(String[] args) throws Exception {
        Class c = Class.forName("src.ReflectDemo.ReflectFixFinal.pojo.FinalStraightPerson");
        Object m = c.newInstance();
        Method printMethod = c.getDeclaredMethod("printInfo");
        printMethod.invoke(m);

        Field nameField = c.getDeclaredField("name");
        Field ageField = c.getDeclaredField("age");
        nameField.setAccessible(true);
        ageField.setAccessible(true);
        nameField.set(m,"Drunkbaby as Drun1baby");
        ageField.set(m,"19");

        printMethod.invoke(m);
    }
}
