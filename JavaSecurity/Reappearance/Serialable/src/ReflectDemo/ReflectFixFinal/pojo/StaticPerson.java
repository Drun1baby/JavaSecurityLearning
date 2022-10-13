package src.ReflectDemo.ReflectFixFinal.pojo;

public class Person {
    private static StringBuilder name = new StringBuilder("john");

    public void printInfo() {
        System.out.println(name);

    }
}
