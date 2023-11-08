package com.drunkbaby.defaultTyping.object_and_non_concrete;

import com.drunkbaby.Person;
import com.drunkbaby.Hacker;
import com.fasterxml.jackson.databind.ObjectMapper;

public class OBJECT_AND_NON_CONCRETE_Test {
    public static void main(String[] args) throws Exception {
        Person p = new Person();
        p.age = 6;
        p.name = "drunkbaby";
        p.object = new Hacker();
        p.sex = new MySex();
        ObjectMapper mapper = new ObjectMapper();
        // 设置OBJECT_AND_NON_CONCRETE
        mapper.enableDefaultTyping(ObjectMapper.DefaultTyping.OBJECT_AND_NON_CONCRETE);
        // 或直接无参调用，输出一样
        //mapper.enableDefaultTyping();

        String json = mapper.writeValueAsString(p);
        System.out.println(json);

        Person p2 = mapper.readValue(json, Person.class);
        System.out.println(p2);
    }
}
