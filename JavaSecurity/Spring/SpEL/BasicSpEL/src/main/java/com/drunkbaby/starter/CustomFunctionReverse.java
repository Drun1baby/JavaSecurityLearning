package com.drunkbaby.starter;

import com.drunkbaby.custom.ReverseString;
import org.springframework.expression.ExpressionParser;
import org.springframework.expression.spel.standard.SpelExpressionParser;
import org.springframework.expression.spel.support.StandardEvaluationContext;

public class CustomFunctionReverse {
    public static void main(String[] args) throws NoSuchMethodException {
        ExpressionParser parser = new SpelExpressionParser();
        StandardEvaluationContext context = new StandardEvaluationContext();
        context.registerFunction("reverseString",
                ReverseString.class.getDeclaredMethod("reverseString", new Class[] { String.class }));
        String helloWorldReversed = parser.parseExpression("#reverseString('Drunkbaby')").getValue(context, String.class);
        System.out.println(helloWorldReversed);
    }
}
