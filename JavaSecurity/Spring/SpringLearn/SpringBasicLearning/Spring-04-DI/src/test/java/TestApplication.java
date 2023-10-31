import org.junit.Test;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import com.drunkbaby.pojo.Student;


public class TestApplication {
    @Test
    public void TestApplication() {
        ApplicationContext context = new ClassPathXmlApplicationContext("beans.xml");
        //在执行getBean的时候, user已经创建好了 , 通过无参构造
        Student student = (Student) context.getBean("student");
        System.out.println(student);
    }
}