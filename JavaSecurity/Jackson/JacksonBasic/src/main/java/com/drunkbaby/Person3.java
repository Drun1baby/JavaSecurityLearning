package com.drunkbaby;

import com.drunkbaby.defaultTyping.object_and_non_concrete.Sex;
import com.fasterxml.jackson.annotation.JsonTypeInfo;

// 反序列化时用到的 Person 类
public class Person3 {
    public int age;
    public String name;
//    @JsonTypeInfo(use = JsonTypeInfo.Id.CLASS)
    // 或 @JsonTypeInfo(use = JsonTypeInfo.Id.MINIMAL_CLASS)
    public Sex sex;

    public Person3() {
        System.out.println("Person3 构造函数");
    }

    public void setAge(int age) {
        System.out.println("Person3 setter 函数");
    }

    @Override
    public String toString() {
        return String.format("Person.age=%d, Person.name=%s, %s", age, name, sex == null ? "null" : sex);
    }
}
