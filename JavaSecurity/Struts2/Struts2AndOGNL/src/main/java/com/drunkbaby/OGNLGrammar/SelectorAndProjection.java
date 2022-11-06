package com.drunkbaby.OGNLGrammar;

import com.drunkbaby.pojo.User;
import ognl.Ognl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

public class SelectorAndProjection {
    public static void main(String[] args) throws Exception{
        User p1 = new User("name1", 11);
        User p2 = new User("name2", 22);
        User p3 = new User("name3", 33);
        User p4 = new User("name4", 44);
        Map<String, Object> context = new HashMap<String, Object>();
        ArrayList<User> list = new ArrayList<User>();
        list.add(p1);
        list.add(p2);
        list.add(p3);
        list.add(p4);
        context.put("list", list);
        System.out.println(Ognl.getValue("#list.{age}", context, list));
// [11, 22, 33, 44]
        System.out.println(Ognl.getValue("#list.{age + '-' + name}", context, list));
// [11-name1, 22-name2, 33-name3, 44-name4]
        System.out.println(Ognl.getValue("#list.{? #this.age > 22}", context, list));
// [User(name=name3, age=33, address=null), User(name=name4, age=44, address=null)]
        System.out.println(Ognl.getValue("#list.{^ #this.age > 22}", context, list));
// [User(name=name3, age=33, address=null)]
        System.out.println(Ognl.getValue("#list.{$ #this.age > 22}", context, list));
// [User(name=name4, age=44, address=null)]
    }
}
