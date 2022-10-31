package SerializeTest;

import org.yaml.snakeyaml.Yaml;

public class YamlSerialize {
    public static void main(String[] args) {
    //    serialize();
        unserialize();
    }
    public static void serialize(){
        Person person = new Person();
        person.setName("Drunkbaby");
        person.setAge(20);
        person.setSchool("cuz");
        person.setProvince("zj");
        Yaml yaml = new Yaml();
        String str = yaml.dump(person);
        System.out.println(str);
    }
    public static void unserialize(){
        String str1 = "!!SerializeTest.Person {age: 20, name: Drunkbaby, province: zj, school: cuz}";
//        String str2 = "age: 20\n" +
//                "name: Drunkbaby";
        Yaml yaml = new Yaml();
        yaml.load(str1);
//        yaml.loadAs(str2, Person.class);
    }
}
