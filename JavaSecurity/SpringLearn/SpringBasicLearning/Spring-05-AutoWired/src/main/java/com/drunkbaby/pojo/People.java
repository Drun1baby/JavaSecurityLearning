package com.drunkbaby.pojo;

import org.springframework.beans.factory.annotation.Autowired;

public class People {

    @Autowired
    private Cat cat;
    @Autowired
    private Rabbit rabbit;
    private String name;

    @Override
    public String toString() {
        return "People{" +
                "cat=" + cat +
                ", rabbit=" + rabbit +
                ", name='" + name + '\'' +
                '}';
    }

    public Rabbit getRabbit() {
        return rabbit;
    }

    public Cat getCat() {
        return cat;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

}