package com.drunkbaby.OGNLGrammar;

import ognl.Ognl;
import com.drunkbaby.pojo.Address;
import com.drunkbaby.pojo.User;

public class VisitRoot {
    public static void main(String[] args) throws Exception{
        User user = new User("Drunkbaby", 20);
        Address address = new Address("330108", "杭州市滨江区");
        user.setAddress(address);
        System.out.println(Ognl.getValue("name", user));	// Drunkbaby
        System.out.println(Ognl.getValue("name.length()", user));		// 9
        System.out.println(Ognl.getValue("address", user));		// Address(port=330108, address=杭州市滨江区)
        System.out.println(Ognl.getValue("address.port", user));	// 330108
    }
}
