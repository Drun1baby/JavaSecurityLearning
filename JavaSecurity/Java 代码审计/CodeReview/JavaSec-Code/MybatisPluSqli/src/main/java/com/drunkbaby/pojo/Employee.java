package com.drunkbaby.pojo;

import com.baomidou.mybatisplus.annotation.TableName;

@TableName("employees")
public class Employee {

    private Integer id;
    private String name;
    private String work;

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

    public String getWork() {
        return work;
    }

    public void setWork(String work) {
        this.work = work;
    }
}
