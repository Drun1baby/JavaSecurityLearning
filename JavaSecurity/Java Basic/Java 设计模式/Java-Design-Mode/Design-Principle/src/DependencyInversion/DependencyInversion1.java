package DependencyInversion;

public class DependencyInversion1 {
    public static void main(String[] args) {
        Person person = new Person();
        person.receive(new Email());
    }
}

class Email {
    public String getInfo() {
        return "电子邮件：Hello World!!!";
    }
}

class Person {
    public void receive(Email e) {
        System.out.println(e.getInfo());
    }
}
