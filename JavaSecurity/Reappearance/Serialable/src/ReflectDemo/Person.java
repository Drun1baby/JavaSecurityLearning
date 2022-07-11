package src.ReflectDemo;

import java.io.Serializable;

public class Person implements Serializable{

    private String name;
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
        System.out.println("睡眠中..." + age);
        return "sleep";
    }
    public void reflect(){
        System.out.println("弹弹弹，射射射");
    }
/* 第一种情况    入口类的 readObject() 直接调用危险方法
   private void readObject(ObjectInputStream ois) throws IOException, ClassNotFoundException{
        ois.defaultReadObject();
        Runtime.getRuntime().exec("calc");
    }*/
}
