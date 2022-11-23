package com.drunkbaby.OGNLGrammar;

import ognl.Ognl;

public class CreateClass {
    public static void main(String[] args) throws Exception{
        System.out.println(Ognl.getValue("#{'key1':'value1'}", null));	// {key1=value1}
        System.out.println(Ognl.getValue("{'key1','value1'}", null));	// [key11, value1]
        System.out.println(Ognl.getValue("new com.drunkbaby.pojo.User()", null));
// User(name=null, age=0, address=null)
    }
}
