
import config.MyConfig;
import org.junit.Test;
import org.springframework.context.ApplicationContext;
import org.springframework.context.annotation.AnnotationConfigApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import pojo.User;


public class ConfigTestApplication {
    @Test
    public void TestApplication() {
        ApplicationContext applicationContext = new AnnotationConfigApplicationContext(MyConfig.class);
        User user = (User) applicationContext.getBean("getUser");
        System.out.println(user.getName());
    }
}