package src.DynamicClassLoader.ClassLoaderPackage;

// 存放代码块
public class Person {
    public static int staticVar;
    public int instanceVar;

    static {
        System.out.println("静态代码块");
    }

    {
        System.out.println("构造代码块");
    }

    Person(){
        System.out.println("无参构造器");
    }
    Person(int instanceVar){
        System.out.println("有参构造器");
    }

    public static void staticAction(){
        System.out.println("静态方法");
    }
}
