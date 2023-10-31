import org.junit.Test;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import com.drunkbaby.pojo.People;


public class TestAutoWired {
    @Test
    public void TestApplication() {
        ApplicationContext context = new ClassPathXmlApplicationContext("beans.xml");
        People people = context.getBean("people",People.class);
        people.getCat().shout();
        people.getRabbit().shout();
    }
}