package src.ReflectDemo.ReflectFixFinal.pojo;

public class PrivateFinalPerson {
    private final StringBuilder name = new StringBuilder("Drunkbaby");

    public void printName() {
        System.out.println(name);
    }
}
