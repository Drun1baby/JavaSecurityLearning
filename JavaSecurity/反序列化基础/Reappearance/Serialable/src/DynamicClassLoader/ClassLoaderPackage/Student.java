package src.DynamicClassLoader.ClassLoaderPackage;

// 双亲委派的正确代码
public class Student {

    public String toString(){
        return "Hello";
    }

    public static void main(String[] args) {
        Student student = new Student();

        System.out.println(student.getClass().getClassLoader());
        System.out.println(student.toString());
    }
}
