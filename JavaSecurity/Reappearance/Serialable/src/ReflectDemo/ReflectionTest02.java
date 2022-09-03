package src.ReflectDemo;

import java.lang.reflect.Method;

// 获取类中的方法
public class ReflectionTest02 {
    public static void main(String[] args) throws Exception{
        Class c1 = Class.forName("src.ReflectDemo.Person");// 创建 Class 对象
        Method[] methods1 = c1.getDeclaredMethods();// 获取所有该类中的所有方法
        Method[] methods2 = c1.getMethods();// 获取所有的 public 方法，包括类自身声明的 public 方法，父类中的  、实现的接口方法

        for (Method m:methods1){
            System.out.println(m);
        }
        System.out.println("-------分割线---------");

        for (Method m:methods2) {
            System.out.println(m);
        }

        System.out.println("-------分割线---------");

        Method methods3 = c1.getMethod("study", String.class);// 获取 Public 的 study 方法
        System.out.println(methods3);
        System.out.println("-------分割线---------");

        Method methods4 = c1.getDeclaredMethod("sleep", int.class); // 获取 Private 的 sleep 方法
        System.out.println(methods4);
    }

}
