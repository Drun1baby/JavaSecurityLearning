package SerializeTest;

public class Person {

    private String name;
    private Integer age;
    public String school;
    protected String province;

    public String getSchool() {
        System.out.println("getSchool 方法被调用");
        return school;
    }

    public void setSchool(String school) {
        System.out.println("setSchool 方法被调用");
        this.school = school;
    }

    public String getProvince() {
        System.out.println("getProvince 方法被调用");
        return province;
    }

    public void setProvince(String province) {
        System.out.println("setProvince 方法被调用");
        this.province = province;
    }

    public Person() {
        System.out.println("构造函数被调用");
    }

    public void printInfo(){
        System.out.println("name is " + this.name + "age is" + this.age);
    }

    public String getName() {
        System.out.println("getName 方法被调用");
        return name;
    }

    public void setName(String name) {
        System.out.println("setName 方法被调用");
        this.name = name;
    }

    public Integer getAge() {
        System.out.println("getAge 方法被调用");
        return age;
    }

    public void setAge(Integer age) {
        System.out.println("setAge 方法被调用");
        this.age = age;
    }
}
