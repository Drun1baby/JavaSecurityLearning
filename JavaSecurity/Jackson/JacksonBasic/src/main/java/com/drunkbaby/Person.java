package com.drunkbaby;

import com.drunkbaby.defaultTyping.object_and_non_concrete.Sex;

// 基础序列化与反序列化（多态实现）
public class Person {
    public int age;
    public String name;
    public Object object;
    public Sex sex;
    public Hacker hacker;

    @Override
    public String toString() {
        return String.format("Person.age=%d, Person.name=%s, %s, %s, %s", age, name, object == null ? "null" : object, sex == null ? "null" : sex, hacker == null ? "null" : hacker);
    }
}