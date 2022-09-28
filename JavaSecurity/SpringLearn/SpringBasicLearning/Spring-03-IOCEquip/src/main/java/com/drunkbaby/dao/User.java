package com.drunkbaby.dao;

public class User {
    private String name;

    public User() {
        System.out.println("user无参构造方法");
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public void show(){
        System.out.println("name="+ name );
    }
}