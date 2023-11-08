package com.drunkbaby.JsonTypeInfo.JsonTypeInfo_Id;

import com.drunkbaby.Hacker;
import com.drunkbaby.Person2;
import com.fasterxml.jackson.databind.ObjectMapper;

public class JsonTypeInfo_Id_Test {
    public static void main(String[] args) throws Exception {
        Person2 p = new Person2();
        p.age = 6;
        p.name = "drunkbaby";
        p.object = new Hacker();
        ObjectMapper mapper = new ObjectMapper();

        String json = mapper.writeValueAsString(p);
        System.out.println(json);

        Person2 p2 = mapper.readValue(json, Person2.class);
        System.out.println(p2);
    }
}