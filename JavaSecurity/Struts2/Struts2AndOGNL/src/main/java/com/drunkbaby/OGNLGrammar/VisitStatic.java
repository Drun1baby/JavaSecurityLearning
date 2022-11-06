package com.drunkbaby.OGNLGrammar;

import ognl.Ognl;
import ognl.OgnlException;

// 对静态变量的访问（@[class]@[field/method()]）
public class VisitStatic {

    public static String ONE = "VisitStatic Success";

    public static void main(String[] args) throws Exception{
        AtVisit();
    }
    public static void AtVisit() throws OgnlException {
        Object object1 = Ognl.getValue("@com.drunkbaby.OGNLGrammar.VisitStatic@ONE", null);
        Object object2 = Ognl.getValue("@com.drunkbaby.OGNLGrammar.VisitContext@VisitContextMethod()", null);	// hello、Drunkbaby、Drunkbaby
        System.out.println(object1);	// 访问 static 的 ONE
        System.out.println(object2);	// 访问 VisitContext 的 VisitContextMethod() 方法
    }
}
