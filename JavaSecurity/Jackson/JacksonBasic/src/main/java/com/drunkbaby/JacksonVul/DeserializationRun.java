package com.drunkbaby.JacksonVul;

import com.drunkbaby.Person3;
import com.fasterxml.jackson.databind.ObjectMapper;

// 反序列化代码
public class DeserializationRun {
    public static void main(String[] args) throws Exception {
        ObjectMapper mapper = new ObjectMapper();
        mapper.enableDefaultTyping();

        String json = "{\"age\":6,\"name\":\"drunkbaby\",\"sex\":[\"com.drunkbaby.JacksonVul.EvilSex\",{\"sex\":1}]}";
        Person3 p2 = mapper.readValue(json, Person3.class);
        System.out.println(p2);

    }
}
