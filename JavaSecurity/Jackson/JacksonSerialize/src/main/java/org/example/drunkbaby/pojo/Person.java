package org.example.drunkbaby.pojo;

// 基础序列化与反序列化（多态实现）
public class Person {
    public int age;
    public String name;
    public Object object;
    public Sex sex;
    public Hacker hacker;

    public int getAge() {
        return age;
    }

    public void setAge(int age) {
        this.age = age;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Object getObject() {
        return object;
    }

    public void setObject(Object object) {
        this.object = object;
    }

    @Override
    public String toString() {
        return String.format("Person.age=%d, Person.name=%s, %s, %s, %s", age, name, object == null ? "null" : object, sex == null ? "null" : sex, hacker == null ? "null" : hacker);
    }
}