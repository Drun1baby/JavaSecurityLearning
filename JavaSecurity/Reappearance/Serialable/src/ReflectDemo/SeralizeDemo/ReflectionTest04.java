package src.ReflectDemo;

import java.lang.reflect.Field;

// 获取类的属性
public class ReflectionTest04 {
    public static void main(String[] args) throws Exception{
        Class c = Class.forName("src.ReflectDemo.Person");

        // 用数组获取
        Field[] personField = c.getDeclaredFields();
        for (Field f:personField) {
            System.out.println(f);
        }

        System.out.println("---------分割线--------");

        Field[] personField2 = c.getFields();
        for (Field f:personField2) {
            System.out.println(f);
        }
    }
}
