package com.drunkbaby.defaultTyping.non_concrete_and_arrays;

import com.drunkbaby.Person;
import com.drunkbaby.Hacker;
import com.drunkbaby.defaultTyping.object_and_non_concrete.MySex;
import com.fasterxml.jackson.databind.ObjectMapper;

public class NON_CONCRETE_AND_ARRAYS_Test {
    public static void main(String[] args) throws Exception {
        Person p = new Person();
        p.age = 6;
        p.name = "drunkbaby";
        Hacker[] hackers = new Hacker[2];
        hackers[0] = new Hacker();
        hackers[1] = new Hacker();
        p.object = hackers;
        p.sex = new MySex();
        ObjectMapper mapper = new ObjectMapper();
        // 设置NON_CONCRETE_AND_ARRAYS
        mapper.enableDefaultTyping(ObjectMapper.DefaultTyping.NON_CONCRETE_AND_ARRAYS);

        String json = mapper.writeValueAsString(p);
        System.out.println(json);

        Person p2 = mapper.readValue(json, Person.class);
        System.out.println(p2);
    }
}
