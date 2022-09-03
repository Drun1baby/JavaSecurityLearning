package src.ReflectDemo;

import java.lang.reflect.Field;
import java.lang.reflect.Method;

// 实例化与修改属性
public class ReflectionTest05 {
    public static void main(String[] args) throws Exception{
        Person person = new Person();
        Class c = person.getClass();

        Field nameField = c.getField("name");
        nameField.set(person, "Drunkbaby");
        System.out.println(person);

        System.out.println("---------分割线--------");

        Field ageField = c.getDeclaredField("age");
        ageField.setAccessible(true);
        ageField.set(person, 19);
        System.out.println(person);
    }
}
