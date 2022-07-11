package src.DynamicClassLoader.ClassLoaderPackage;

// 代码块的启动器
public class Main {
    public static void main(String[] args) throws ClassNotFoundException{
        // 场景一、Person person = new Person();
        // 场景二、Person.staticAction();
        // 场景三、Person.staticVar = 1;
        // 场景四、Class c = Person.class;
        // 场景五、1. Class.forName("src.DynamicClassLoader.ClassLoaderPackage.Person");
        //        2. Class.forName("src.DynamicClassLoader.ClassLoaderPackage.Person", true, ClassLoader.getSystemClassLoader());
        //        3. Class.forName("src.DynamicClassLoader.ClassLoaderPackage.Person", false, ClassLoader.getSystemClassLoader());
    }
}
