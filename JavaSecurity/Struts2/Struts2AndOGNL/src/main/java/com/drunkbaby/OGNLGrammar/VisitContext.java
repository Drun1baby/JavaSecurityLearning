package com.drunkbaby.OGNLGrammar;

import ognl.Ognl;
import com.drunkbaby.pojo.Address;
import com.drunkbaby.pojo.User;

import java.util.HashMap;
import java.util.Map;

public class VisitContext {
    public static void main(String[] args) throws Exception{
        VisitContextMethod();
    }

    private static void VisitContextMethod() throws Exception{
        User user = new User("Drunkbaby", 20);
        Address address = new Address("330108", "杭州市滨江区");
        user.setAddress(address);
        Map<String, Object> context = new HashMap<String, Object>();
        context.put("init", "hello");
        context.put("user", user);
        System.out.println(Ognl.getValue("#init", context, user));	// hello
        System.out.println(Ognl.getValue("#user.name", context, user));	// test
        System.out.println(Ognl.getValue("name", context, user));	// test
    }
}
