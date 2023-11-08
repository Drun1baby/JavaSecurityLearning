package com.drunkbaby.deserialization;

import com.drunkbaby.Person;
import com.drunkbaby.Person3;
import com.fasterxml.jackson.databind.ObjectMapper;

// 两种反序列化方式之二，最终结果等效
public class DeserializationTest2 {

    public static void main(String[] args) throws Exception {
        ObjectMapper mapper = new ObjectMapper();
//        mapper.enableDefaultTyping();

        String json = "{\"age\":6,\"name\":\"drunkbaby\",\"sex\":[\"com.drunkbaby.deserialization.MySex2\",{\"sex\":1}]}";
        Person3 p2 = mapper.readValue(json, Person3.class);
        System.out.println(p2);

    }
}
