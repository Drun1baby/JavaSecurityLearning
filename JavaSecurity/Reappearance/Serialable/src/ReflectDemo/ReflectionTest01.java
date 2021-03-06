package src.ReflectDemo;


// 三种获取类的方法
public class ReflectionTest01 {
    public static void main(String[] args) throws Exception{
        // 类的 .class 属性
        Class c1 = Person.class;
        System.out.println(c1.getName());

        // 实例化对象的 getClass() 方法
        Person person = new Person();
        Class c2 = person.getClass();
        System.out.println(c2.getName());

        // Class.forName(String className): 动态加载类
        Class c3 = Class.forName("src.Person");
        System.out.println(c3.getName());

        //Person person = new Person();
        //Class c = person.getClass();
        // 反射就是操作 Class

        // 从原型 class 里面实例化对象

        // 获取类里面属性

        // 调用类里面的方法
    }
}
