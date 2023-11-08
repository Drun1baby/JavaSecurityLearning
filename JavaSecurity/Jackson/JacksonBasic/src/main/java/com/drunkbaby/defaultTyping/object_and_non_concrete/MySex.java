package com.drunkbaby.defaultTyping.object_and_non_concrete;

public class MySex implements Sex {
    int sex;

    @Override
    public int getSex() {
        return sex;
    }

    @Override
    public void setSex(int sex) {
        this.sex = sex;
    }
}
