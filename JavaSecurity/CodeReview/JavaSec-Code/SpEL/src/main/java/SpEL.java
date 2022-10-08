import org.springframework.expression.ExpressionParser;
import org.springframework.expression.spel.standard.SpelExpressionParser;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class SpEL {

    // 具体的 PoC 整理在这篇文章里面 https://drun1baby.github.io/2022/09/23/Java-%E4%B9%8B-SpEL-%E8%A1%A8%E8%BE%BE%E5%BC%8F%E6%B3%A8%E5%85%A5/

    /**
     * http://localhost:8080/spel/vul/?expression=xxx.
     * SpEL 表达式注入
     * @param expression
     * @return
     */
    @GetMapping("/spel/vuln")
    public String SpELRce(String expression) {
        ExpressionParser expressionParser = new SpelExpressionParser();
        return expressionParser.parseExpression(expression).getValue().toString();
    }
}
