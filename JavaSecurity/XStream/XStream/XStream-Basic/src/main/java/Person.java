public class Person implements IPerson {
    String name;
    int age;

    public void output() {
        System.out.print("Hello, this is " + this.name + ", age " + this.age);
    }
}