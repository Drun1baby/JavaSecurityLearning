package com.drunkbaby;

public class Person {
    public int age;
    public String name;

    @Override
    public String toString() {
        return String.format("com.drunkbaby.Person.age=%d, com.drunkbaby.Person.name=%s", age, name);
    }
}