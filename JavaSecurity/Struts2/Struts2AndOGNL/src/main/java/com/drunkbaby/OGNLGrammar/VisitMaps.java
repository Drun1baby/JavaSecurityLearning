package com.drunkbaby.OGNLGrammar;

import com.drunkbaby.pojo.User;
import ognl.Ognl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

public class VisitMaps {
    public static void main(String[] args) throws Exception{
        User user = new User();
        Map<String, Object> context = new HashMap<String, Object>();
        String[] strings  = {"aa", "bb"};
        ArrayList<String> list = new ArrayList<String>();
        list.add("aa");
        list.add("bb");
        Map<String, String> map = new HashMap<String, String>();
        map.put("key1", "value1");
        map.put("key2", "value2");
        context.put("list", list);
        context.put("strings", strings);
        context.put("map", map);
        System.out.println(Ognl.getValue("#strings[0]", context, user));	// aa
        System.out.println(Ognl.getValue("#list[0]", context, user));	// aa
        System.out.println(Ognl.getValue("#list[0 + 1]", context, user));	// bb
        System.out.println(Ognl.getValue("#map['key1']", context, user));	// value1
        System.out.println(Ognl.getValue("#map['key' + '2']", context, user)); 	// value2
    }
}
