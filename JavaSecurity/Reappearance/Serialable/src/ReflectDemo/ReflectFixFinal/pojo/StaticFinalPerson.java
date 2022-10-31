package src.ReflectDemo.ReflectFixFinal.pojo;

public class StaticFinalPerson {
    static final StringBuilder name = new StringBuilder("Drunkbaby");

    public void printInfo() {
        System.out.println(name);

    }
}
