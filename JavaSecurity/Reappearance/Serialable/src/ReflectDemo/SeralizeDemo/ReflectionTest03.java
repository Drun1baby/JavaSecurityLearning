package src.ReflectDemo;

import java.lang.reflect.Constructor;

// 获取构造函数
public class ReflectionTest03 {
    public static void main(String[] args) throws Exception{
        Class c1 = Class.forName("src.ReflectDemo.PersonConstructor");
        Constructor[] constructors1 = c1.getDeclaredConstructors();
        Constructor[] constructors2 = c1.getConstructors();
        for (Constructor c : constructors1){
            System.out.println(c);
        }
        System.out.println("-------分割线---------");
        for (Constructor c : constructors2){
            System.out.println(c);
        }
        System.out.println("-------分割线---------");
        Constructor constructors3 = c1.getConstructor(String.class, int.class);
        System.out.println(constructors3);
        System.out.println("-------分割线---------");
        Constructor constructors4 = c1.getDeclaredConstructor(String.class);
    }
}
