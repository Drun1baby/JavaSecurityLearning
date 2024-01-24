package com.drunkbaby.OGNLGrammar;

import ognl.Ognl;
import ognl.OgnlException;

public class Test {
    public static void main(String[] args) throws OgnlException {
        String expression = "#{9*9}";
        Object expr = Ognl.parseExpression(expression);
        Object value = Ognl.getValue(expr, expression);
        System.out.println(value);
    }
}
