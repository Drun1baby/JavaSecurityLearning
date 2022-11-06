package com.drunkbaby.OGNLGrammar;

import com.drunkbaby.pojo.User;
import ognl.Ognl;

import java.util.HashMap;
import java.util.Map;

public class MethodCall {
    public static void main(String[] args) throws Exception{
        User user = new User();
        Map<String, Object> context = new HashMap<String, Object>();
        context.put("name", "Drunkbaby");
        context.put("password", "password");
        System.out.println(Ognl.getValue("getName()", context, user));	// null
        Ognl.getValue("setName(#name)", context, user);
        System.out.println(Ognl.getValue("getName()", context, user));	// Drunkbaby
    }
}
