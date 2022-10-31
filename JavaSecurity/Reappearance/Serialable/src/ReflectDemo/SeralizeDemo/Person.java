package src.ReflectDemo.SeralizeDemo;

import java.io.IOException;
import java.io.ObjectInputStream;
import java.io.Serializable;

public class Person implements Serializable{

    public String name;
    private int age;

    public Person(){

    }
    // 构造函数
    public Person(String name, int age){
        this.name = name;
        this.age = age;
    }
    @Override
    public String toString(){
        return "Person{" +
                "name='" + name + '\'' +
                ", age=" + age +
                '}';
    }
    public void study(String s) {
        System.out.println("学习中..." + s);
    }
    private String sleep(int age) {
        System.out.println("已经睡了..." + age + " 小时");
        return "sleep";
    }
    public void reflect(){
        System.out.println("Person 类的反射方法被调用");
    }
/* 第一种情况    入口类的 readObject() 直接调用危险方法 /*

 */
   private void readObject(ObjectInputStream ois) throws IOException, ClassNotFoundException{
        ois.defaultReadObject();
        Runtime.getRuntime().exec("calc");
        // system('cmd')
    }
}
