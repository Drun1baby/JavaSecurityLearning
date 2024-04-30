package org.example.drunkbaby.main;

import com.fasterxml.jackson.databind.ObjectMapper;
import org.example.drunkbaby.pojo.Person;

public class SerializeTest {
    public static void main(String[] args) throws Exception {
        Person p = new Person();
        p.age = 6;
        p.name = "Drunkbaby";
        ObjectMapper mapper = new ObjectMapper();

        String json = mapper.writeValueAsString(p);
        System.out.println(json);
    }
}
