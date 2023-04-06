package shiro;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import shiro.service.UserService;
import shiro.service.UserServiceImpl;

@SpringBootTest
class ShiroApplicationTests {

    @Autowired
    UserServiceImpl userService;


    @Test
    void contextLoads() {
        System.out.println(userService.queryUserByName("drunkbaby"));
    }

}
