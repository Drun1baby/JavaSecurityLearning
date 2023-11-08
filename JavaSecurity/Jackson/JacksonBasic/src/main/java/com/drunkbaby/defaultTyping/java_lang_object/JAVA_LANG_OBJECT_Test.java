package com.drunkbaby.defaultTyping.java_lang_object;

import com.drunkbaby.Hacker;
import com.drunkbaby.Person;
import com.fasterxml.jackson.databind.ObjectMapper;

public class JAVA_LANG_OBJECT_Test {
    public static void main(String[] args) throws Exception {
        Person p = new Person();
        p.age = 6;
        p.name = "drunkbaby";
        p.object = new Hacker();
        ObjectMapper mapper = new ObjectMapper();
        // 设置JAVA_LANG_OBJECT
        mapper.enableDefaultTyping(ObjectMapper.DefaultTyping.JAVA_LANG_OBJECT);

        String json = mapper.writeValueAsString(p);
        System.out.println(json);

        Person p2 = mapper.readValue(json, Person.class);
        System.out.println(p2);
    }
}
