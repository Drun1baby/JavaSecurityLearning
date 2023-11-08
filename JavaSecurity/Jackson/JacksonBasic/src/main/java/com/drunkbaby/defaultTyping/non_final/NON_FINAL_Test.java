package com.drunkbaby.defaultTyping.non_final;

import com.drunkbaby.Person;
import com.drunkbaby.Hacker;
import com.drunkbaby.defaultTyping.object_and_non_concrete.MySex;
import com.fasterxml.jackson.databind.ObjectMapper;

public class NON_FINAL_Test {
    public static void main(String[] args) throws Exception {
        Person p = new Person();
        p.age = 6;
        p.name = "drunkbaby";
        p.object = new Hacker();
        p.sex = new MySex();
        p.hacker = new Hacker();
        ObjectMapper mapper = new ObjectMapper();
        // 设置NON_FINAL
        mapper.enableDefaultTyping(ObjectMapper.DefaultTyping.NON_FINAL);

        String json = mapper.writeValueAsString(p);
        System.out.println(json);

        Person p2 = mapper.readValue(json, Person.class);
        System.out.println(p2);
    }
}
