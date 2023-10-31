package src.ReflectDemo.ReflectFixFinal.pojo;

public class StaticPerson {
    private static StringBuilder name = new StringBuilder("Drunkbaby");

    public void printInfo() {
        System.out.println(name);

    }
}
