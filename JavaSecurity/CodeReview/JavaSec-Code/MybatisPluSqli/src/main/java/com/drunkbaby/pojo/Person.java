package com.drunkbaby.pojo;


import com.baomidou.mybatisplus.annotation.TableName;

@TableName("person")
public class Person {

    private Integer id;
    private String name;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }
}
