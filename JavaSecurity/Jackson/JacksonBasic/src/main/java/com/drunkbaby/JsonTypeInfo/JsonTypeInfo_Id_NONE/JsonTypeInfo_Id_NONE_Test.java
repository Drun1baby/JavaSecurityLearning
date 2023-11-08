package com.drunkbaby.JsonTypeInfo.JsonTypeInfo_Id_NONE;

import com.drunkbaby.Hacker;
import com.drunkbaby.Person;
import com.fasterxml.jackson.databind.ObjectMapper;

public class JsonTypeInfo_Id_NONE_Test {
    public static void main(String[] args) throws Exception {
        Person p = new Person();
        p.age = 6;
        p.name = "mi1k7ea";
        p.object = new Hacker();
        ObjectMapper mapper = new ObjectMapper();

        String json = mapper.writeValueAsString(p);
        System.out.println(json);

        Person p2 = mapper.readValue(json, Person.class);
        System.out.println(p2);
    }
}