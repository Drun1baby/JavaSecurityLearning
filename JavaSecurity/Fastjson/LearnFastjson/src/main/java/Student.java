import java.util.Properties;

public class Student {
    private String name;
    private int age;
    private String address;
    private Properties properties;

    public Student() {
        System.out.println("构造函数");
    }

    public String getName() {
        System.out.println("getName");
        return name;
    }

    public void setName(String name) {
        System.out.println("setName");
        this.name = name;
    }

    public int getAge() {
        System.out.println("getAge");
        return age;
    }

//    public void setAge(int age) {
//        System.out.println("setAge");
//        this.age = age;
//    }

    public String getAddress() {
        System.out.println("getAddress");
        return address;
    }

    public Properties getProperties() throws Exception{
            System.out.println("getProperties");
            Runtime.getRuntime().exec("calc");
            return properties;
    }
}