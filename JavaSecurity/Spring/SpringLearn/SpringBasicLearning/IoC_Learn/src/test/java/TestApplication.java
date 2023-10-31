import DAO.MysqlUserDaoImpl;
import Service.UserServiceImpl;
import org.junit.Test;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;


public class TestApplication {
    @Test
    public void TestApplication() {
        // 获取ApplicationContext；拿到Spring容器
        ApplicationContext context = new ClassPathXmlApplicationContext("beans.xml");

        // 需要什么就直接get什么！
        UserServiceImpl userServiceImpl = (UserServiceImpl) context.getBean("UserServiceImpl");
        userServiceImpl.getUser();
    }
}