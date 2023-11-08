package com.drunkbaby.deserialization;

import com.drunkbaby.defaultTyping.object_and_non_concrete.Sex;

public class MySex2 implements Sex {
    int sex;
    public MySex2() {
        System.out.println("MySex构造函数");
    }

    @Override
    public int getSex() {
        System.out.println("MySex.getSex");
        return sex;
    }

    @Override
    public void setSex(int sex) {
        System.out.println("MySex.setSex");
        this.sex = sex;
    }
}