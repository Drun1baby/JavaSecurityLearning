import org.junit.Test;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import com.drunkbaby.pojo.User;


public class Test2 {
    @Test
    public void TestApplication() {
        ApplicationContext context = new ClassPathXmlApplicationContext("userBeans.xml");
        //在执行getBean的时候, user已经创建好了 , 通过无参构造
        User user = (User) context.getBean("user");
        System.out.println(user);

        User user1 = (User) context.getBean("user2");
        System.out.println(user1);
    }
}