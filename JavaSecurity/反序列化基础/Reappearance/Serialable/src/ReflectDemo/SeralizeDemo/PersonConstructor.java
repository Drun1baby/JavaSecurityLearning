package src.ReflectDemo.SeralizeDemo;


public class PersonConstructor {

    private String name;
    private int age;

    // 无参构造
    public PersonConstructor(){

    }
    // 构造函数
    public PersonConstructor(String name, int age){
        this.name = name;
        this.age = age;
    }
    // 私有构造函数
    private PersonConstructor(String name){
        this.name = name;
    }

    @Override
    public String toString(){
        return "Person{" +
                "name='" + name + '\'' +
                ", age=" + age +
                '}';
    }

}
