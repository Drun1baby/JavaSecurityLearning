package com.hession.test;

import java.io.Serializable;

public class Person implements Serializable {
    public String name;
    public int age;

    public int getAge() {
        return age;
    }

    @Override
    public String toString() {
        return super.toString();
    }

    public String getName() {
        return name;
    }

    public void setAge(int age) {
        this.age = age;
    }

    public void setName(String name) {
        this.name = name;
    }
}