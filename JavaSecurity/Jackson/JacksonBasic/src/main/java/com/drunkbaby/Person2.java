package com.drunkbaby;

import com.fasterxml.jackson.annotation.JsonTypeInfo;

// JsonTypeInfo.Id.xxx 实现
public class Person2 {
    public int age;
    public String name;
    @JsonTypeInfo(use = JsonTypeInfo.Id.NAME)
    public Object object;

    @Override
    public String toString() {
        return String.format("Person.age=%d, Person.name=%s, %s", age, name, object == null ? "null" : object);
    }
}