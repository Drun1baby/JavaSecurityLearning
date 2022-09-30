package com.drunkbaby.starter;

import org.springframework.expression.EvaluationContext;
import org.springframework.expression.ExpressionParser;
import org.springframework.expression.spel.standard.SpelExpressionParser;
import org.springframework.expression.spel.support.StandardEvaluationContext;


// 变量定义与引用
public class VariableUse {
    public static void main(String[] args) {
        ExpressionParser parser = new SpelExpressionParser();
        EvaluationContext context = new StandardEvaluationContext("Drunkbaby");
        context.setVariable("variable", "777");
        String result1 = parser.parseExpression("#variable").getValue(context, String.class);
        System.out.println(result1);
        String result2 = parser.parseExpression("#root").getValue(context, String.class);
        System.out.println(result2);
        String result3 = parser.parseExpression("#this").getValue(context, String.class);
        System.out.println(result3);
    }
}
