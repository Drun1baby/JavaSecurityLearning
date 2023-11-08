package com.drunkbaby.JacksonVul;

import com.drunkbaby.defaultTyping.object_and_non_concrete.Sex;

public class EvilSex implements Sex {
    int sex;
    public EvilSex() {
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
        try {
            Runtime.getRuntime().exec("calc");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}