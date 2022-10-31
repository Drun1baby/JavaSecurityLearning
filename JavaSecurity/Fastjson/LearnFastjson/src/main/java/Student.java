import java.util.Properties;

public class Student {
    private String name;
    private int age;
    String cmd;

    public String getCmd() {
        System.out.println("getCmd");
        return cmd;
    }

    public void setCmd(String cmd) throws Exception{
        System.out.println("setCmd");
        this.cmd = cmd;
        Runtime.getRuntime().exec(this.cmd);
    }

    private String address;

    private Properties properties;

    public Student() {
        System.out.println("构造函数");
    }

    public String getName(String cmd) throws Exception{
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

    public void setAge(int age) {
        System.out.println("setAge");
        this.age = age;
    }

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