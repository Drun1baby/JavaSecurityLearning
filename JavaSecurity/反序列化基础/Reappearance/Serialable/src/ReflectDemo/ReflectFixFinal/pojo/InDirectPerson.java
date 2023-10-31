package src.ReflectDemo.ReflectFixFinal.pojo;

public class InDirectPerson {
    private final StringBuilder sex = new StringBuilder("male");
    // 经过逻辑判断产生的变量赋值
    public final int age = (null!=null?18:18);
    // 通过构造函数进行赋值
    private final String name;
    public InDirectPerson(){
        name = "Drunkbaby";
    }

    public void printInfo() {
        System.out.println(name+" "+age+" "+sex);

    }
}
